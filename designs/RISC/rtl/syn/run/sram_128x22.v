module tsyncram_128x22 














(CLK, CLKN, ADDR, WEN, WE, REN, RE, CSN, CSB, DATA_IN, DATA_OUT); 

input CLK; 
input CLKN; 
input [6:0] ADDR; 
input WEN; 
input WE; 
input REN; 
input RE; 
input CSN; 
input CSB; 
input [21:0] DATA_IN; 
output [21:0] DATA_OUT; 


SYHD130_128X22X1CM8 SRAM 
( 
.CK (CLK), 
.A0 (ADDR[0]), 
.A1 (ADDR[1]), 
.A2 (ADDR[2]), 
.A3 (ADDR[3]), 
.A4 (ADDR[4]), 
.A5 (ADDR[5]), 
.A6 (ADDR[6]), 

.CSB (1'b0), 
.WEB (WEN), 

.DI0 (DATA_IN[0]), 
.DI1 (DATA_IN[1]), 
.DI2 (DATA_IN[2]), 
.DI3 (DATA_IN[3]), 
.DI4 (DATA_IN[4]), 
.DI5 (DATA_IN[5]), 
.DI6 (DATA_IN[6]), 
.DI7 (DATA_IN[7]), 
.DI8 (DATA_IN[8]), 
.DI9 (DATA_IN[9]), 
.DI10 (DATA_IN[10]), 
.DI11 (DATA_IN[11]), 
.DI12 (DATA_IN[12]), 
.DI13 (DATA_IN[13]), 
.DI14 (DATA_IN[14]), 
.DI15 (DATA_IN[15]), 
.DI16 (DATA_IN[16]), 
.DI17 (DATA_IN[17]), 
.DI18 (DATA_IN[18]), 
.DI19 (DATA_IN[19]), 
.DI20 (DATA_IN[20]), 
.DI21 (DATA_IN[21]), 
.DO0 (DATA_OUT[0]), 
.DO1 (DATA_OUT[1]), 
.DO2 (DATA_OUT[2]), 
.DO3 (DATA_OUT[3]), 
.DO4 (DATA_OUT[4]), 
.DO5 (DATA_OUT[5]), 
.DO6 (DATA_OUT[6]), 
.DO7 (DATA_OUT[7]), 
.DO8 (DATA_OUT[8]), 
.DO9 (DATA_OUT[9]), 
.DO10 (DATA_OUT[10]), 
.DO11 (DATA_OUT[11]), 
.DO12 (DATA_OUT[12]), 
.DO13 (DATA_OUT[13]), 
.DO14 (DATA_OUT[14]), 
.DO15 (DATA_OUT[15]), 
.DO16 (DATA_OUT[16]), 
.DO17 (DATA_OUT[17]), 
.DO18 (DATA_OUT[18]), 
.DO19 (DATA_OUT[19]), 
.DO20 (DATA_OUT[20]), 
.DO21 (DATA_OUT[21]) 
); 

endmodule 