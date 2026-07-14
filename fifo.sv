module fifo (
    input clk,
    input rst_n,
    input w_en,
    input r_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full,
    output empty
);

// Memory array — 8 locations, each 8 bits wide
reg [7:0] mem [0:7];

// Pointers
reg [2:0] w_ptr;
reg [2:0] r_ptr;
  
  // Write logic
always @(posedge clk) begin
    if (!rst_n) begin
        w_ptr <= 0;
    end
    else if (w_en && !full) begin
        mem[w_ptr] <= data_in;
        w_ptr <= w_ptr + 1;
    end
end
  
  // Read logic
always @(posedge clk) begin
    if (!rst_n) begin
        r_ptr <= 0;
        data_out <= 0;
    end
    else if (r_en && !empty) begin
        data_out <= mem[r_ptr];
        r_ptr <= r_ptr + 1;
    end
end
  
  // Full and empty flags
assign empty = (w_ptr == r_ptr);
assign full = (w_ptr[2] != r_ptr[2]) && (w_ptr[1:0] == r_ptr[1:0]);
  

endmodule
