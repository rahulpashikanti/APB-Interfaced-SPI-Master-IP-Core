`timescale 1ns/1ns

module slave_control_select_tb;

reg         pclk;
reg         presetn;
reg         mstr_i;
reg         spiswai_i;
reg  [1:0]  spi_mode_i;
reg         send_data_i;
reg  [11:0] baud_rate_divisor_i;

wire        ss_o;
wire        receive_data_o;
wire        tip_o;


// DUT

slave_control_select DUT
(
    .pclk(pclk),
    .presetn(presetn),
    .mstr_i(mstr_i),
    .spiswai_i(spiswai_i),
    .spi_mode_i(spi_mode_i),
    .send_data_i(send_data_i),
    .baud_rate_divisor_i(baud_rate_divisor_i),

    .ss_o(ss_o),
    .receive_data_o(receive_data_o),
    .tip_o(tip_o)
);


// Clock Generation

initial
begin
    pclk = 1'b0;
    forever #5 pclk = ~pclk;
end


// Reset Task

task reset_dut;
begin
    presetn = 1'b0;
    #20;
    presetn = 1'b1;
end
endtask


// Initialize Task

task initialize;
begin
    mstr_i              = 1'b1;
    spiswai_i           = 1'b0;
    spi_mode_i          = 2'b00;
    send_data_i         = 1'b0;
    baud_rate_divisor_i = 12'd4;
end
endtask


// Send Data Task

task data_send_signal;
begin

    @(posedge pclk);
    send_data_i = 1'b1;

    @(posedge pclk);
    send_data_i = 1'b0;

end
endtask


// Stimulus Task

task stimulus;

input [1:0]  mode;
input        wait_hold;
input [11:0] divisor;

begin

    spi_mode_i          = mode;
    spiswai_i           = wait_hold;
    baud_rate_divisor_i = divisor;

    @(posedge pclk);
    send_data_i = 1'b1;

    @(posedge pclk);
    send_data_i = 1'b0;

end

endtask


// Test Cases

initial
begin

    initialize;

    reset_dut;


    // TEST 1
    // Run Mode - Divisor 4

    stimulus(2'b00, 1'b0, 12'd4);

    @(posedge receive_data_o);

    #20;


   /* // TEST 2
    // Run Mode - Divisor 8

    stimulus(2'b00, 1'b0, 12'd8);

    @(posedge receive_data_o);

    #20;


    // TEST 3
    // Run Mode - Divisor 16

    stimulus(2'b00, 1'b0, 12'd16);

    @(posedge receive_data_o);

    #20;


    // TEST 4
    // Wait Mode

    stimulus(2'b01, 1'b0, 12'd4);

    #100;


    // TEST 5
    // Wait Hold Mode

    spi_mode_i  = 2'b01;
    spiswai_i   = 1'b1;
    send_data_i = 1'b1;

    #100;

    send_data_i = 1'b0;


    // TEST 6
    // Stop Mode

    spi_mode_i = 2'b10;

    #100;


    // TEST 7
    // Master Disable

    mstr_i = 1'b0;

    #100;


    // TEST 8
    // Master Enable

    mstr_i = 1'b1;

    stimulus(2'b00, 1'b0, 12'd4);

    @(posedge receive_data_o);

    #20;*/


    $finish;

end


// Monitor

initial
begin

$monitor("PCLK=%b RESET=%b MODE=%b MSTR=%b WAIT=%b SEND=%b DIV=%d SS=%b TIP=%b RCV=%b",
         pclk,
         presetn,
         spi_mode_i,
         mstr_i,
         spiswai_i,
         send_data_i,
         baud_rate_divisor_i,
         ss_o,
         tip_o,
         receive_data_o);

end


// VCD

initial
begin
    $dumpfile("slave_control_select_tb.vcd");
    $dumpvars(1, slave_control_select_tb);
end
endmodule
