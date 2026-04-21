module scratchpad_tb();

    logic clk;
    logic reset;   
    logic write_enable;
    logic [3:0] address;
    logic [7:0] data_in;
    logic [7:0] data_out;

    scratchpad test (
        .clk(clk),
        .reset(reset),      
        .write_enable(write_enable),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 0;
        write_enable = 0;
        address = 4'h0;
        data_in = 8'h00;

        @(posedge clk); #1;
        reset = 1;
        @(posedge clk);
        @(posedge clk); #1;
        reset = 0;
        $display("Reset applied. data_out should be 0: %h", data_out);

        write_enable = 1;
        address = 4'hA;
        data_in = 8'hFF;
        @(posedge clk); #1;
        $display("Wrote 0xFF to address 0xA. data_out should be FF: %h", data_out);

        write_enable = 0;
        address = 4'hA;
        @(posedge clk); #1;
        $display("Read address 0xA. data_out should be FF: %h", data_out);

        write_enable = 1;
        address = 4'h0;
        data_in = 8'hFC;
        @(posedge clk); #1;
        $display("Wrote 0xFC to address 0x0. data_out should be FC: %h", data_out);

        write_enable = 0;
        address = 4'h0;
        @(posedge clk); #1;
        $display("Read address 0x0. data_out should be FC: %h", data_out);

        address = 4'hA;
        @(posedge clk); #1;
        $display("Read address 0xA again. data_out should still be FF: %h", data_out);

        $finish;
    end

endmodule