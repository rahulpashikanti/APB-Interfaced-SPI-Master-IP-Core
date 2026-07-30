module baud_rate(
    input pclk,preset_n,
    input [1:0]spi_mode_i,input spiswai_i,
    input [2:0]sppr_i,spr_i,
    input cpol_i,cpha_i,ss_i, 
    output reg sclk_o,
    output reg miso_pos,miso_neg,mosi_pos,mosi_neg,
    output [11:0]baud_rate_divisor);

reg [11:0]count;
wire pre_sclk;

assign baud_rate_divisor=(sppr_i+1'b1)*(2**(spr_i+1'b1));
assign pre_sclk=(cpol_i) ? 1'b1:1'b0;

always@(posedge pclk or negedge preset_n)
begin
    if(!preset_n)
    begin
        count<=12'b0;
        sclk_o<=pre_sclk;
    end
    else if((spi_mode_i==2'b00||spi_mode_i==2'b01)&&(!ss_i)&&(!spiswai_i))
    begin
        if(count==((baud_rate_divisor/2)-1'b1))
        begin
            count<=12'b0;
            sclk_o<=~sclk_o;
        end
        else
        begin
            count<=count+1'b1;
            sclk_o<=sclk_o;
        end
    end
    else 
    begin
        count<=12'b0;
        sclk_o<=pre_sclk;
    end
end

always@(posedge pclk or negedge preset_n)
begin
    if(!preset_n)
    begin
        miso_pos<=1'b0;
        miso_neg<=1'b0;
    end
    else if((!cpha_i&cpol_i)||(cpha_i&!cpol_i))
    begin
        if(sclk_o)
         begin
            if(count==((baud_rate_divisor/2)-1'b1))
                miso_neg<=1'b1;
            else
                miso_neg<=1'b0;
         end
        else
            miso_neg<=1'b0;
    end
    else
    begin
        if(!sclk_o)
        begin
            if(count==((baud_rate_divisor/2)-1'b1))
                miso_pos<=1'b1;
            else
                miso_pos<=1'b0;
        end
        else
            miso_pos<=1'b0;
    end
end

always@(posedge pclk or negedge preset_n)
begin 
    if(!preset_n)
    begin
        mosi_pos<=1'b0;
        mosi_neg<=1'b0;
    end
    else if((!cpha_i&&cpol_i)||(cpha_i&&!cpol_i))
    begin
        if(sclk_o)
        begin
            if(count==((baud_rate_divisor/2)-2'b10))
                mosi_neg<=1'b1;
            else
                mosi_neg<=1'b0;
        end
        else
            mosi_neg<=1'b0;
    end
    else
    begin
        if(!sclk_o)
        begin
            if(count==((baud_rate_divisor/2)-2'b10))
                mosi_pos<=1'b1;
            else
                mosi_pos<=1'b0;
        end
        else
            mosi_pos<=1'b0;
    end
end

endmodule

