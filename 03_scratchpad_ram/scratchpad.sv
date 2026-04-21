module scratchpad(
    input  logic clk,
    input  logic reset,      
    input  logic write_enable,
    input  logic [3:0] address,
    input  logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] mem [0:15];

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 16; i++) begin
                mem[i] <= 8'b0; 
            end
        end 
        else if (write_enable) begin
            mem[address] <= data_in;    
        end
    end

    assign data_out = mem[address];

endmodule