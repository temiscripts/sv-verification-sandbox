module security_gate_tb();

    logic clk; 
    logic rst; 
    logic password_ok; 
    logic door_open; 

    security_gate first (
        .clk(clk),
        .rst(rst),
        .password_ok(password_ok),
        .door_open(door_open)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin 
        $dumpfile("dump.vcd");
        $dumpvars(0, security_gate_tb);

        // Reset ON, Password OFF
        rst = 1'b1; password_ok = 1'b0; 
        @(posedge clk);
        @(posedge clk);

        // Reset OFF
        #1; rst = 1'b0; 
        @(posedge clk);
        
        // correct password
        #1; password_ok = 1'b1;
        @(posedge clk);
        @(posedge clk);

        // Remove password
        #1; password_ok = 1'b0;
        @(posedge clk);
        @(posedge clk);
        
        $finish;
    end

endmodule