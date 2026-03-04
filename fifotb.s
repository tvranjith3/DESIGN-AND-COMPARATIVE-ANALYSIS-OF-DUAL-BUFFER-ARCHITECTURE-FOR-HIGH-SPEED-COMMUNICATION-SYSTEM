`timescale 1ms/1us

module tb_fifo_async;
reg wr_clk = 0, rd_clk = 0, wr_rst, rd_rst, wr_en, rd_en;
reg [7:0] wr_data;
wire [7:0] rd_data;
wire wr_full, rd_empty;

fifo_async uut (
    .wr_clk(wr_clk), .wr_rst(wr_rst), .wr_en(wr_en), .wr_data(wr_data), .wr_full(wr_full),
    .rd_clk(rd_clk), .rd_rst(rd_rst), .rd_en(rd_en), .rd_data(rd_data), .rd_empty(rd_empty)
);

always #5 wr_clk = ~wr_clk;
always #10 rd_clk = ~rd_clk;

initial begin
    $dumpfile("fifo_async.vcd");
    $dumpvars(0, tb_fifo_async);

    wr_rst = 1; rd_rst = 1; wr_en = 0; rd_en = 0;
    #20 wr_rst = 0; rd_rst = 0;

    repeat (8) begin
        @(posedge wr_clk);
        wr_data = $random;
        wr_en = 1;
    end
    wr_en = 0;

    repeat (8) begin
        @(posedge rd_clk);
        rd_en = 1;
    end
    rd_en = 0;

    #100 $finish;
end
endmodule
