module security_gate(
    input  logic clk,
    input  logic rst,
    input  logic password_ok,
    output logic door_open
);

    typedef enum logic {LOCKED, UNLOCKED} state_t;
    state_t current_state, next_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= LOCKED;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            LOCKED: begin
                if (password_ok)
                    next_state = UNLOCKED;
                else
                    next_state = LOCKED;
            end
            
            UNLOCKED: begin
                if (!password_ok)
                    next_state = LOCKED;
                else
                    next_state = UNLOCKED;
            end
            
            default: next_state = LOCKED;
        endcase
    end

    assign door_open = (current_state == UNLOCKED);

endmodule