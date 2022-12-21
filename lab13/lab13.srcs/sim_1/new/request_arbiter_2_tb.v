`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2022 07:45:10 PM
// Design Name: 
// Module Name: request_arbiter_2_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  Testbench for request arbiter
// 
// Dependencies: request_arbiter_2 or request_arbiter_2_dual
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module request_arbiter_2_tb();
    reg Req0_s, Req1_s, Clk_s, Rst_s;
    wire Grant0_s, Grant1_s;
    parameter ClkPeriod = 20;


    //Initialize component as DeviceUnderTest
    request_arbiter_2_dual DeviceUnderTest (Req0_s, Req1_s,
                     Grant0_s, Grant1_s, 
                     Clk_s, Rst_s);


    //Clock procedure
    always begin //Repeats
        Clk_s <= 0; #(ClkPeriod/2);
        Clk_s <= 1; #(ClkPeriod/2);
    end
    
    
    //Test vector procedure
    initial begin //Runs once
        Rst_s <= 1; Req0_s <= 0; Req1_s <= 0;
        @(posedge Clk_s);#5; //5 ns after clock edge continue
        Rst_s <= 0; Req0_s<=1;
        @(posedge Clk_s);#5;
        if (Grant0_s != 1 || Grant1_s != 0)
            $display("%t: First test failed", $time);
        Req0_s <= 1; Req1_s<=1;
        @(posedge Clk_s);#5;
        Req0_s <= 0; Req1_s<=1;
        @(posedge Clk_s);#5;
        Req0_s <= 1; Req1_s <=1;
        @(posedge Clk_s);#5;
        Req0_s <= 0; Req1_s <=0;
        @(posedge Clk_s);#5;
        Req0_s <= 1; Req1_s <=1;
        @(posedge Clk_s);
        @(posedge Clk_s);#5;
        Req0_s <= 0; Req1_s <=1;
        @(posedge Clk_s);#5;
        Req0_s <= 0; Req1_s <=0;
    end

endmodule
