module tb_fifo;

  reg clk, rst_n, w_en, r_en;
  reg [7:0] data_in;
  wire [7:0] data_out;
  wire full, empty;

  // Connect to FIFO
  fifo dut (
    .clk(clk),
    .rst_n(rst_n),
    .w_en(w_en),
    .r_en(r_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock — toggles every 5 time units
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    // Initialise
    clk=0; rst_n=0; w_en=0; r_en=0; data_in=0;
    
    // Reset
    #10 rst_n=1;
    
    // Write 4 values
    w_en=1;
    data_in=8'hA1; #10;
    data_in=8'hB2; #10;
    data_in=8'hC3; #10;
    data_in=8'hD4; #10;
    w_en=0;
    
    // Read 4 values
    r_en=1;
    #10; #10; #10; #10;
    r_en=0;
    
    #20 $finish;
  end

endmodule
