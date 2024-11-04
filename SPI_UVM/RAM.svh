module RAM(din,clk,rst_n,rx_valid,dout,tx_valid);
//parameters
parameter MEM_DEPTH = 256 ;
parameter ADDER_SIZE = 8;
//inputs
input [9:0] din ; 
input rx_valid;
input rst_n , clk;
//outputs
output reg [ADDER_SIZE-1:0] dout;
output reg tx_valid;
//regs decliration
reg [ADDER_SIZE-1:0] tmp;//Waddress , Raddress;
//memory decleration
reg [ADDER_SIZE-1:0] MEM [MEM_DEPTH-1:0];
always @(posedge clk or negedge rst_n) begin
    //check reset 
    if(~rst_n) begin
        dout <= 0;
        tx_valid <=0;  
    end
    else if(rx_valid) begin
        //check rx_valid signal
            case(din[9:8])
                2'b00: tmp <= din[7:0];
                2'b01: MEM[tmp] <= din[7:0];
                2'b10: tmp <= din[7:0];
                2'b11: begin
                    dout <= MEM[tmp];
                    tx_valid <= 1;
                end
            endcase
        end
end
endmodule

        