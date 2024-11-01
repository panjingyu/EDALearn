






`include "../include/x_def.v" 


module DMDbuf (I, O); 

input [15:0] I; 
output [15:0] O; 

assign O = I; 
endmodule 


module MAbufx (I, O); 

input [13:0] I; 
output [13:0] O; 

assign O = I; 
endmodule 







































`ifdef FD_DFT 
module REG8L (CK, CKenb, WBen, DI, DO, SCAN_TEST); 
input CK, CKenb, WBen, SCAN_TEST; 
`else 
module REG8L (CK, CKenb, WBen, DI, DO); 
input CK, CKenb, WBen; 
`endif 

input [7:0] DI; 
output [7:0] DO; 
reg [7:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK) 
if (WBen) DO[7:0] <= #`db DI[7:0]; 

`else 
always @(posedge CK) 
if (WBen && !CKenb) DO[7:0] <= #`db DI[7:0]; 

`endif 

endmodule 


`ifdef FD_DFT 
module REG9L (CK, CKenb, WBen, DI, DO, SCAN_TEST); 
input CK, CKenb, WBen, SCAN_TEST; 
`else 
module REG9L (CK, CKenb, WBen, DI, DO); 
input CK, CKenb, WBen; 
`endif 

input [8:0] DI; 
output [8:0] DO; 
reg [8:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK) 
if (WBen) DO[8:0] <= #`db DI[8:0]; 

`else 
always @(posedge CK) 
if (WBen && !CKenb) DO[8:0] <= #`db DI[8:0]; 

`endif 

endmodule 


`ifdef FD_DFT 
module REG12L (CK, CKenb, WBen, DI, DO, SCAN_TEST); 
input CK, CKenb, WBen, SCAN_TEST; 
`else 
module REG12L (CK, CKenb, WBen, DI, DO); 
input CK, CKenb, WBen; 
`endif 

input [11:0] DI; 
output [11:0] DO; 
reg [11:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK) 
if (WBen) DO[11:0] <= #`db DI[11:0]; 

`else 
always @(posedge CK) 
if (WBen && !CKenb) DO[11:0] <= #`db DI[11:0]; 
`endif 

endmodule 


`ifdef FD_DFT 
module REG14L (CK, RST, CKenb, WBen, DI, DO, SCAN_TEST); 
input CK, RST, CKenb, WBen, SCAN_TEST; 
`else 
module REG14L (CK, RST, CKenb, WBen, DI, DO); 
input CK, RST, CKenb, WBen; 
`endif 

input [13:0] DI; 
output [13:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

reg [13:0] DO; 
always @(posedge CLK or posedge RST) 
if (RST) DO[13:0] <= #`db 14'b0; 
else if (WBen) DO[13:0] <= #`db DI[13:0]; 

`else 
reg [13:0] DO; 
always @(posedge CK or posedge RST) 
if (RST) DO[13:0] <= #`db 14'b0; 
else if (WBen && !CKenb) DO[13:0] <= #`db DI[13:0]; 

`endif 

endmodule 
`ifdef FD_DFT 
module REG16L (CK, CKenb, WBen, DI, DO, SCAN_TEST); 
input CK, CKenb, WBen, SCAN_TEST; 
`else 
module REG16L (CK, CKenb, WBen, DI, DO); 
input CK, CKenb, WBen; 
`endif 

input [15:0] DI; 
output [15:0] DO; 

`ifdef FD_GTCLK 
`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

reg [15:0] DO; 
always @(posedge CLK) 
if (WBen) DO[15:0] <= #`db DI[15:0]; 
`else 
reg [15:0] DO; 
always @(posedge CK) 
if (WBen && !CKenb) DO[15:0] <= #`db DI[15:0]; 
`endif 

endmodule 




`ifdef FD_DFT 
module REG4LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG4LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [3:0] DI; 
output [3:0] DO; 
reg [3:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[3:0] <= #`db 4'b0; 
else if (WBen) DO[3:0] <= #`db DI[3:0]; 
`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[3:0] <= #`db 4'b0; 
else if (WBen && !CKenb) DO[3:0] <= #`db DI[3:0]; 
`endif 

endmodule 


`ifdef FD_DFT 
module REG5LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG5LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [4:0] DI; 
output [4:0] DO; 
reg [4:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[4:0] <= #`db 5'b0; 
else if (WBen) DO[4:0] <= #`db DI[4:0]; 
`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[4:0] <= #`db 5'b0; 
else if (WBen && !CKenb) DO[4:0] <= #`db DI[4:0]; 
`endif 


endmodule 
`ifdef FD_DFT 
module REG7LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG7LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [6:0] DI; 
output [6:0] DO; 
reg [6:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[6:0] <= #`db 7'b0; 
else if (WBen) DO[6:0] <= #`db DI[6:0]; 

`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[6:0] <= #`db 7'b0; 
else if (WBen && !CKenb) DO[6:0] <= #`db DI[6:0]; 
`endif 

endmodule 

`ifdef FD_DFT 
module REG8LCI (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG8LCI (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [7:0] DI; 
output [7:0] DO; 
reg [7:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[7:0] <= #`db 8'b01010101; 
else if (WBen) DO[7:0] <= #`db DI[7:0]; 

`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[7:0] <= #`db 8'b01010101; 
else if (WBen && !CKenb) DO[7:0] <= #`db DI[7:0]; 
`endif 

endmodule 

`ifdef FD_DFT 
module REG9LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG9LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [8:0] DI; 
output [8:0] DO; 
reg [8:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[8:0] <= #`db 9'b0; 
else if (WBen) DO[8:0] <= #`db DI[8:0]; 

`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[8:0] <= #`db 9'b0; 
else if (WBen && !CKenb) DO[8:0] <= #`db DI[8:0]; 
`endif 

endmodule 


`ifdef FD_DFT 
module REG11LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG11LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [10:0] DI; 
output [10:0] DO; 
reg [10:0] DO; 

`ifdef FD_GTCLK 

GTECH_NOT uu0 (.Z(CLR_), .A(CLR)); 
`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[10:0] <= #`db 11'b0; 
else if (WBen) DO[10:0] <= #`db DI[10:0]; 

`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[10:0] <= #`db 11'b0; 
else if (WBen && !CKenb) DO[10:0] <= #`db DI[10:0]; 
`endif 

endmodule 


`ifdef FD_DFT 
module REG12LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG12LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [11:0] DI; 
output [11:0] DO; 
reg [11:0] DO; 

`ifdef FD_GTCLK 

GTECH_NOT uu0 (.Z(CLR_), .A(CLR)); 
`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[11:0] <= #`db 12'b0; 
else if (WBen) DO[11:0] <= #`db DI[11:0]; 

`else 

always @(posedge CK or posedge CLR) 
if (CLR) DO[11:0] <= #`db 12'b0; 
else if (WBen && !CKenb) DO[11:0] <= #`db DI[11:0]; 

`endif 

endmodule 


`ifdef FD_DFT 
module REG14LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG14LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [13:0] DI; 
output [13:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

reg [13:0] DO; 
always @(posedge CLK or posedge CLR) 
if (CLR) DO[13:0] <= #`db 14'b0; 
else if (WBen) DO[13:0] <= #`db DI[13:0]; 

`else 

reg [13:0] DO; 
always @(posedge CK or posedge CLR) 
if (CLR) DO[13:0] <= #`db 14'b0; 
else if (WBen && !CKenb) DO[13:0] <= #`db DI[13:0]; 

`endif 

endmodule 

`ifdef FD_DFT 
module REG16LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module REG16LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [15:0] DI; 
output [15:0] DO; 
reg [15:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[15:0] <= #`db 16'b0; 
else if (WBen) DO[15:0] <= #`db DI[15:0]; 
`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[15:0] <= #`db 16'b0; 
else if (WBen && !CKenb) DO[15:0] <= #`db DI[15:0]; 
`endif 

endmodule 



`ifdef FD_DFT 
module REG2D8L (CK, CKenb, WBen, DI1, DI2, DO, SCAN_TEST); 
input CK, CKenb, WBen, SCAN_TEST; 
`else 
module REG2D8L (CK, CKenb, WBen, DI1, DI2, DO); 
input CK, CKenb, WBen; 
`endif 

input [7:0] DI1, DI2 ; 
output [7:0] DO; 
reg [7:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK) begin 
if (WBen) DO[7:0] <= #`db DI1[7:0]; 
else DO[7:0] <= #`db DI2[7:0]; 
end 

`else 
always @(posedge CK) begin 
if (WBen && !CKenb) DO[7:0] <= #`db DI1[7:0]; 
else if(!CKenb) DO[7:0] <= #`db DI2[7:0]; 
end 

`endif 

endmodule 


`ifdef FD_DFT 
module REG2D16L (CK, CKenb, WBen, DI1, DI2, DO, SCAN_TEST); 
input CK, CKenb, WBen, SCAN_TEST; 
`else 
module REG2D16L (CK, CKenb, WBen, DI1, DI2, DO); 
input CK, CKenb, WBen; 
`endif 

input [15:0] DI1, DI2; 
output [15:0] DO; 
reg [15:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu0(.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK) begin 
if (WBen) DO[15:0] <= #`db DI1[15:0]; 
else DO[15:0] <= #`db DI2[15:0]; 
end 
`else 
always @(posedge CK) begin 
if (WBen && !CKenb) DO[15:0] <= #`db DI1[15:0]; 
else if(!CKenb) DO[15:0] <= #`db DI2[15:0]; 
end 
`endif 

endmodule 



`ifdef FD_DFT 
module SREG16MC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module SREG16MC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [15:0] DI; 
output [15:0] DO; 
reg [15:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[15:0] <= #`db 16'h0800; 
else if (WBen) DO[15:0] <= #`db DI[15:0]; 

`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[15:0] <= #`db 16'h0800; 
else if (WBen && !CKenb) DO[15:0] <= #`db DI[15:0]; 
`endif 

endmodule 



`ifdef FD_DFT 
module MREG16MC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module MREG16MC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [15:0] DI; 
output [15:0] DO; 
reg [15:0] DO; 

`ifdef FD_GTCLK 

`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[15:0] <= #`db {2'h3, 4'h0, 3'h7, 3'h7, 4'hf}; 
else if (WBen) DO[15:0] <= #`db DI[15:0]; 

`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[15:0] <= #`db {2'h3, 4'h0, 3'h7, 3'h7, 4'hf}; 
else if (WBen && !CKenb) DO[15:0] <= #`db DI[15:0]; 
`endif 

endmodule 



`ifdef FD_DFT 
module EREG15LC (CK, CKenb, WBen, DI, DO, CLR, SCAN_TEST); 
input CK, CKenb, WBen, CLR, SCAN_TEST; 
`else 
module EREG15LC (CK, CKenb, WBen, DI, DO, CLR); 
input CK, CKenb, WBen, CLR; 
`endif 

input [14:0] DI; 
output [14:0] DO; 
reg [14:0] DO; 

`ifdef FD_GTCLK 
`ifdef FD_DFT 
GTECH_AND_NOT utm0 (.A(CKenb), .B(SCAN_TEST), .Z(CKenb_dft)); 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb_dft)); 
`else 
OR2LC uu1 (.O(CLK), .I1(CK), .I2(CKenb)); 
`endif 

always @(posedge CLK or posedge CLR) 
if (CLR) DO[14:0] <= #`db 15'h7fff; 
else if (WBen) DO[14:0] <= #`db DI[14:0]; 

`else 
always @(posedge CK or posedge CLR) 
if (CLR) DO[14:0] <= #`db 15'h7fff; 
else if (WBen && !CKenb) DO[14:0] <= #`db DI[14:0]; 
`endif 

endmodule 





module IDEBN (SCLK, IN, OUT); 


input SCLK, IN; 
output OUT; 

reg IN_syn, OUT; 
wire OUT_di; 

always @(posedge SCLK) 
begin 
IN_syn <= #1 IN; 
OUT <= #1 OUT_di; 
end 

assign OUT_di = OUT ? (IN | IN_syn) : (IN & IN_syn); 


endmodule 





module Delaya (i, o); 
input i; 
output o; 

Delbufx u1 (.I(i), .O(o)); 
endmodule 

module Oneshot (i, o); 

input i; 
output o; 
wire deli; 
wire del1, del2, del3, del4, del5, del6, del7, del8, del9; 


Delbufx Delbuf1 (i,del1); 
Delbufx Delbuf2 (del1,del2); 
Delbufx Delbuf3 (del2,del3); 
Delbufx Delbuf4 (del3,del4); 
Delbufx Delbuf5 (del4,del5); 
Delbufx Delbuf6 (del5,del6); 
Delbufx Delbuf7 (del6,del7); 
Delbufx Delbuf8 (del7,del8); 
Delbufx Delbuf9 (del8,del9); 
Delbufx Delbufa (del9,deli); 

assign #`da o = i && !deli; 

endmodule 

module Delbufx (I, O); 
input I; 
output O; 
assign #0.1 O = I; 
endmodule 


module HALFP (RST, 
CLK, 
IN, 
`ifdef FD_DFT 
SCAN_TEST, 
`endif 
WEP1); 

input RST, CLK, IN; 
`ifdef FD_DFT 
input SCAN_TEST; 
`endif 
output WEP1; 

reg FFout; 
wire FFout_d, CLR, CLK_; 
wire FFout_d1, FFout_d2, FFout_d3, FFout_d4; 

assign #`db CLK_ = ~CLK; 

always @(posedge CLK or posedge CLR) 
if (CLR) FFout <= #`db 1'b0; 
else FFout <= #`db IN; 



Delbufx Delbuf1 (FFout,FFout_d1); 
Delbufx Delbuf2 (FFout_d1,FFout_d2); 
Delbufx Delbuf3 (FFout_d2,FFout_d3); 
Delbufx Delbuf4 (FFout_d3,FFout_d); 


Delbufx Delbuf0 (FFout_d1,WEP1); 
`ifdef FD_DFT 
wire CLR_h = RST | (CLK_ & FFout_d); 
assign CLR = SCAN_TEST ? RST : CLR_h; 
`else 
assign #`da CLR = RST | (CLK_ & FFout_d); 
`endif 

endmodule 




module OR2LC(I1, I2, O); 
input I1, I2; 
output O; 



GtCLK_NOR2 U0 (.A (I2 ),.B (I1 ),.Z (N1)); 
GtCLK_NOT U1 (.Z (O),.A (N1)); 

endmodule 

















