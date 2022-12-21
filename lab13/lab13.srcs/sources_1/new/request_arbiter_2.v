`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Polito
// Engineer: Andreas S. Bakke   
// 
// Create Date: 12/21/2022 04:56:39 PM
// Design Name: 2 request arbiter
// Module Name: request_arbiter_2
// Project Name: 2 request arbiter
// Target Devices: simulation
// Tool Versions: Vivado 2022.1
// Description: Lab 13 - 1 Procedure design with priority to 0
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module request_arbiter_2(Req0, Req1, Grant0, Grant1, Clk, Rst);
    input Req0, Req1;
    output Grant0, Grant1;
    input Clk, Rst;
    
    reg G0, G1;
    
    parameter IDLE = 0, ACTIVE0 = 1, ACTIVE1 = 2; //Define possible states
    reg[1:0] State; //Register for storing state.


    always @(posedge Clk) begin
        if(Rst == 1) begin
           State <= IDLE;
           G0 <= 0; G1 <= 0;
        end
        else begin
            case(State)
                IDLE: begin
                    G0 <= 0; G1 <= 0;
                    if(Req0 ==1) //Priority for 0
                        State <= ACTIVE0;   
                    else if(Req1 == 1) 
                        State <= ACTIVE1;
                    else
                        State <= IDLE;
                end //IDLE
                
                ACTIVE0: begin
                    G0 <= 1; G1 <= 0;
                    if(Req0 ==1) //Let 0 keep resource
                        State <= ACTIVE0;   
                    else if(Req1 == 1) 
                        State <= ACTIVE1;
                    else
                        State <= IDLE;
                end //ACTIVE0
                
                ACTIVE1: begin
                    G0 <= 0; G1 <= 1;
                    if(Req1 ==1) //Let 1 keep resource
                        State <= ACTIVE1;   
                    else if(Req0 == 1) 
                        State <= ACTIVE0;
                    else
                        State <= IDLE;
                end //ACTIVE1
                
                default: begin //Catch state 11 & others
                    G0 <= 0; G1 <= 0;
                    State <= IDLE;
                end
            endcase //Case(State)    
        end //Clock else
    end
    assign Grant0 =G0;
    assign Grant1 =G1;
endmodule
