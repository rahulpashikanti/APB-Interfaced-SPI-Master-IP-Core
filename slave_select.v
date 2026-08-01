module slave_select(input pclk,preset_n,mstr_i,spiswai_i,
			input [1:0]spi_mode_i,
			input send_data_i,
			input [11:0]baud_rate_divisor,
			output reg receive_data_o,ss_o,
			output tip_o);
wire [15:0]target;
assign target =8*baud_rate_divisor;
reg [15:0]count;
reg rcv;
assign tip_o=~ss_o;
always@(posedge pclk or negedge preset_n)
	begin
		if(!preset_n)
			ss_o<=1'b1;
		else if(!spiswai_i && (spi_mode_i==2'b00 ||spi_mode_i==2'b01) && mstr_i)
		begin
			if(!send_data_i)
			begin
				if(count<=target-1'b1)
					ss_o<=1'b0;
				else
					ss_o<=1'b1;
			end
	   		else
		             ss_o<=1'b0;		
		end
		else
			ss_o<=1'b1;
	end

always@(posedge pclk or negedge preset_n)
	begin
		if(!preset_n)
			count<=16'hffff;
		else if(!spiswai_i && (spi_mode_i==2'b00 || spi_mode_i==2'b01) && mstr_i)
			begin
				if(!send_data_i)
				begin
					if(count<=target-1'b1)
						count<=count+1'b1;
					else
						count<=16'hffff;
				end
				else
					count<=16'b0;
			end
		else
		       count<=16'hffff;
	end	
always@(posedge pclk or negedge preset_n)
	begin
		if(!preset_n)
			rcv<=1'b0;
		else if(!spiswai_i && (spi_mode_i==2'b00 || spi_mode_i==2'b01) && mstr_i)
		begin
			if(!send_data_i)
			begin
				if(count<=target-1'b1)
				begin
					if(count==target-1'b1)
						rcv<=1'b1;
					else
						rcv<=1'b0;
				end
				else
					rcv<=1'b0;
			end
			else
				rcv<=1'b0;
		end
		else
			rcv<=1'b0;
	end	
always@(posedge pclk or negedge preset_n)
	begin
		if(!preset_n)
			receive_data_o<=1'b0;
		else
			receive_data_o<=rcv;
	end
endmodule
