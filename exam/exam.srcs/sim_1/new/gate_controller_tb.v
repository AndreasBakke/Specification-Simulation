`timescale 1ns/1ps

module gate_controller_tb();
    reg F_s, B_s, OK_s, Clk_s, RSTn_s;
    wire [1:0] TL_s;
    parameter ClkPeriod = 10;


    //Initialize component as DeviceUnderTest
    Gate_Controller DeviceUnderTest (.F (F_s), .B (B_s), .OK (OK_s),
                                     .Clk (Clk_s), .RSTn (RSTn_s),
                                     .TL (TL_s));
    
    //Clock procedure
    always begin
        Clk_s <= 0; #(ClkPeriod/2);
        Clk_s <= 1; #(ClkPeriod/2);
    end //always begin    
    
    //TestVector procedure
    
    initial begin
        RSTn_s <= 0; F_s <= 0; B_s <= 0; OK_s <= 0;
        @(posedge Clk_s)#5;
        RSTn_s <= 1;
        if(TL_s != 2'b00)
            $display("%t: First test failed %d", $time, TL_s);
        @(posedge Clk_s)#5;
        F_s <= 1;
        @(posedge Clk_s)#5;
        if(TL_s != 2'b10) //Should be in READ state
            $display("%t: Second test failed", $time);
        OK_s <= 1;

        @(posedge Clk_s)#5;
        if(TL_s != 2'b01) //Should be in OPEN state
            $display("%t: Third test failed", $time);
        @(posedge Clk_s)#5;
        if(TL_s != 2'b01) //Should still be in OPEN state
            $display("%t: Fourth test failed", $time);
        F_s <= 0;
        
        @(posedge Clk_s)#5;
        if(TL_s != 2'b10) //Should be in Crossing state
            $display("%t: Fourth test failed", $time);
        B_s <= 1; 
        @(posedge Clk_s)#5;
        if(TL_s != 2'b00) //Should still be back in IDLE state
            $display("%t: Fourth test failed", $time);


    
    end //testVector initial
        
endmodule
