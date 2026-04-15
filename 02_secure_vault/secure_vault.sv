module secure_vault(
    input  logic clk,
    input  logic rst,
    input  logic [3:0] password_in, 
    output logic vault_open
);

    localparam logic [3:0] SECRET_CODE = 4'b1100; 

    typedef enum logic {LOCKED, UNLOCKED} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) current_state <= LOCKED;
        else     current_state <= next_state;
    end

always_comb begin
        case (current_state)
            LOCKED: begin
                if (password_in == SECRET_CODE) begin
                    next_state = UNLOCKED;
                end else begin
                    next_state = LOCKED; 
                end
            end
            
            UNLOCKED: begin
                if (password_in != SECRET_CODE) begin
                    next_state = LOCKED;
                end else begin
                    next_state = UNLOCKED; 
                end
            end
            
            default: next_state = LOCKED;
        endcase
    end

    assign vault_open = (current_state == UNLOCKED);

endmodule

