module secure_vault_tb();

    logic clk;
    logic rst;
    logic [3:0] password_in;
    logic vault_open;

    secure_vault uut (
        .clk(clk),
        .rst(rst),
        .password_in(password_in),
        .vault_open(vault_open)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1; password_in = 4'b0000;
        @(posedge clk);
        @(posedge clk);
        #1; rst = 0;

        password_in = 4'b1111; 
        @(posedge clk);       
        #1;                   
        
        $display("--- Running Test 1: Wrong Password ---");
        if (vault_open == 1'b0) begin
            $display("PASS: Vault correctly stayed locked.");
        end else begin
            $error("FAIL: Vault opened with wrong password!");
        end
        $display("----------------------------------------");

        @(posedge clk);
        password_in = 4'b1100; 
        @(posedge clk);        
        #1;                    
        
        $display("--- Running Test 2: Correct Password ---");
        if (vault_open == 1'b1) begin
            $display("PASS: Vault correctly opened.");
        end else begin
            $error("FAIL: Vault stayed locked with correct password!");
        end
        $display("----------------------------------------");

        @(posedge clk);
        $stop;
    end

endmodule