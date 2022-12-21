`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2022 07:57:42 PM
// Design Name: 
// Module Name: request_arbiter_2_dual
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module request_arbiter_2_dual(Req0, Req1, Grant0, Grant1, Clk, Rst);
    input Req0, Req1;
    output Grant0, Grant1;
    input Clk, Rst;
    //Regs for updating out-signals
    reg G0, G1;
    parameter IDLE = 0, ACTIVE0 =1, ACTIVE1=2;
    reg[1:0] State, NextState;
    
    //Register procedure
    always @(posedge Clk) begin
        if (Rst == 1)
            State <= IDLE;
        else
            State <= NextState;
    end
    
    //Combinatorial procedure
    always @* begin
        case(State)
        IDLE: begin
            G0 <= 0; G1 <= 0;
            if (Req0 == 1)
                NextState <= ACTIVE0;
            else if (Req1 == 1)
                NextState <= ACTIVE1;
            else
                NextState <= IDLE;
        end
        
        ACTIVE0: begin
            G0 <= 1; G1 <= 0;
            if (Req0 == 1)
                NextState <= ACTIVE0;
            else if (Req1 == 1)
                NextState <= ACTIVE1;
            else
                NextState <= IDLE;
        end
        
        ACTIVE1: begin
            G0 <= 0; G1 <= 1;
            if (Req1 == 1)
                NextState <= ACTIVE1;
            else if (Req0 == 1)
                NextState <= ACTIVE0;
            else
                NextState <= IDLE;
        end
        endcase
    end
    
    assign Grant0 = G0;
    assign Grant1 = G1;
endmodule
