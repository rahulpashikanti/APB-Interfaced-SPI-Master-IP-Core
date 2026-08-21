 module slave_control_select(
    pclk,
    presetn,
    mstr_i,
    spiswai_i,
    spi_mode_i,
    send_data_i,
    baud_rate_divisor_i,
    receive_data_o,
    ss_o,
    tip_o
);

input pclk;
input presetn;
input mstr_i;
input spiswai_i;
input send_data_i;

input [1:0] spi_mode_i;
input [11:0] baud_rate_divisor_i;

output reg receive_data_o;
output reg ss_o;
output wire tip_o;

parameter RUN  = 2'b00;
parameter WAIT = 2'b01;

reg rcv;
reg [15:0] count;

wire [7:0] target;


// Receive data output

always @(posedge pclk or negedge presetn)
begin
    if (!presetn)
        receive_data_o <= 1'b0;
    else
        receive_data_o <= rcv;
end


// Receive generation

always @(posedge pclk or negedge presetn)
begin
    if (!presetn)
        rcv <= 1'b0;
    else
    begin
        if ((spiswai_i == 0) &&
            ((spi_mode_i == 2'b00) || (spi_mode_i == 2'b01)) &&
            (mstr_i == 1))
        begin
            if (send_data_i)
                rcv <= 1'b0;

            else if (count <= target - 1'b1)
            begin
                if (count == target - 1'b1)
                    rcv <= 1'b1;
                else
                    rcv <= 1'b0;
            end

            else
                rcv <= 1'b0;
        end

        else
            rcv <= 1'b0;
    end
end


// Slave select signal generator

always @(posedge pclk or negedge presetn)
begin
    if (!presetn)
        ss_o <= 1'b1;

    else
    begin
        if ((spiswai_i == 0) &&
            ((spi_mode_i == 2'b00) || (spi_mode_i == 2'b01)) &&
            (mstr_i == 1))
        begin
            if (send_data_i)
                ss_o <= 1'b0;

            else if (count <= target - 1'b1)
                ss_o <= 1'b0;

            else
                ss_o <= 1'b1;
        end

        else
            ss_o <= 1'b1;
    end
end


// Counter

always @(posedge pclk or negedge presetn)
begin
    if (!presetn)
        count <= 16'hffff;

    else
    begin
        if ((spiswai_i == 0) &&
            ((spi_mode_i == 2'b00) || (spi_mode_i == 2'b01)) &&
            (mstr_i == 1))
        begin
            if (send_data_i)
                count <= 16'b0;

            else if (count <= target - 1'b1)
                count <= count + 1'b1;

            else
                count <= 16'hffff;
        end

        else
            count <= 16'hffff;
    end
end


// Target count
// Baud rate divisor = 4
// Target = 4 * 8 = 32

assign target = baud_rate_divisor_i * 8;


// TIP signal

assign tip_o = ~ss_o;

endmodule

