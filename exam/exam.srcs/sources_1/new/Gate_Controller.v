`timescale 1ns/1ps

module Gate_Controller(F, B, OK, TL, Clk, RSTn);
    input F, B, OK, Clk, RSTn;
    output [1:0] TL;
    
    reg[1:0] TL_reg;
    
    parameter IDLE=0, READ=1, OPEN=2, CROSSING=3;
    reg[1:0] CurrState, NextState;

    //State procedure
    always@(posedge Clk or negedge RSTn) begin
        if(RSTn==0)
            CurrState <= IDLE;
        else if(Clk == 1)
            CurrState <= NextState;
    end //always
    
    
    //CombLogic procedure
    always@(F, B, OK, CurrState) begin
        case(CurrState)
            IDLE: begin
                if(F == 1)begin
                    NextState <= READ;
                    TL_reg <= 0'b10;
                end
                else begin
                    NextState <= IDLE;
                    TL_reg <= 0'b00;
                end
            end //IDLE
            
            READ: begin
                if(OK == 1) begin
                    NextState <= OPEN;
                    TL_reg <= 2'b01;
                end
                else begin
                    NextState <= READ;
                    TL_reg <= 2'b10;
                end
            end //READ     
            
            OPEN: begin
                if(F==0) begin
                    NextState <= CROSSING;
                    TL_reg <= 2'b10;
                end
                else begin
                    NextState <= OPEN;
                    TL_reg <= 2'b01;
                end
            end //OPEN
            
            CROSSING: begin
                if(B==1)begin
                    NextState <= IDLE;
                    TL_reg <= 2'b00;
                end
                else begin
                    NextState <= CROSSING;
                    TL_reg <= 2'b10;
                end
            end //CROSSING
        endcase
    
    end //always (forgotten in handed in solution)
    assign TL = TL_reg;
endmodule