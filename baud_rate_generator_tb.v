module baud_rate_tb();

reg pclk,preset_n;
reg [1:0] spi_mode_i;
reg spiswai_i;
reg [2:0] sppr_i,spr_i;
reg cpol_i,cpha_i,ss_i;

wire sclk_o,miso_pos,miso_neg,mosi_pos,mosi_neg;
wire [11:0] baud_rate_divisor;

baud_rate dut(
    pclk,preset_n,
    spi_mode_i,spiswai_i,
    sppr_i,spr_i,
    cpol_i,cpha_i,ss_i,
    sclk_o,
    miso_pos,miso_neg,mosi_pos,mosi_neg,
    baud_rate_divisor
);

initial
begin
    pclk=1'b0;
    forever #10 pclk=~pclk;
end

task reset;
begin
    @(negedge pclk)
    preset_n=1'b0;
    @(negedge pclk)
    preset_n=1'b1;
end
endtask

task initialize;
begin
    pclk=1'b0;
    preset_n=1'b0;
    spi_mode_i=2'b00;
    sppr_i=3'b000;
    spr_i=3'b000;
    spiswai_i=1'b0;
    cpol_i=1'b1;
    cpha_i=1'b0;
    ss_i=1'b0;
end
endtask

task stimulus(input [2:0] i,input [2:0] j,input x,input y);
begin
    spi_mode_i=2'b01;
    sppr_i=i;
    spr_i=j;
    spiswai_i=1'b0;
    cpol_i=x;
    cpha_i=y;
    ss_i=1'b0;
end
endtask

initial
begin
    initialize;
    reset;

    stimulus(3'b001,3'b001,1'b1,1'b1);
    #200;

    stimulus(3'b001,3'b001,1'b0,1'b1);
    #200;

    stimulus(3'b001,3'b001,1'b1,1'b0);
    #200;

    stimulus(3'b001,3'b001,1'b0,1'b0);
    #200;
end

initial
begin
    $monitor("baudrate_divisor=%d", baud_rate_divisor);
   
end
endmodule
