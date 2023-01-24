`timescale 1ns/1ps



module elevator_controller(Button, R, G, B, Clk, RSTn);
    input [1:0] Button;
    input Clk, RSTn;
    output R, G, B;
    
    reg R_reg, G_reg, B_reg;
    
    
    parameter GROUND = 0, FIRST = 1, SECOND = 2;
    reg[1:0] CurrFloor, NextFloor;
    
    
    always @(posedge Clk or negedge RSTn) begin
        CurrFloor <= !RSTn ? GROUND : NextFloor  ; //If RSTn = 1 NextFloor else GROUMD
    end //always
    
    always @ (Button, CurrFloor) begin
        case(CurrFloor)
            GROUND: begin
                R_reg <= 1; G_reg <= 0; B_reg <=0;
                if(Button == "10")
                    NextFloor <= FIRST;
                else
                    NextFloor <= GROUND;
            end
            FIRST: begin
                R_reg <= 0; G_reg <= 1; B_reg <=0;
                if(Button =="01")
                    NextFloor <= GROUND;
                else if (Button == "10")
                    NextFloor <= SECOND;
                else
                    NextFloor <= FIRST;
            end
            SECOND: begin
                R_reg <= 0; G_reg <= 0; B_reg <=1;
                if(Button == "01")
                    NextFloor <= FIRST;
                else
                    NextFloor <= SECOND;
            end
         endcase
    end //always
    assign R = R_reg;
    assign G = G_reg;
    assign B = B_reg;
endmodule
    