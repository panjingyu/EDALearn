



















































































module reset_dist 

















( 
SYSCLKF, 




BUSCLKF, 



CFG_SLEEPENABLE, 

X_HALT_R, 

CP0_SLEEP_M_R, SYS_WBEMPTY_W_R, EJC_DINT_R, INTREQ_N, CP0_IM_W_R, EXT_SLEEPREQ_R, 

SL_HALT_W_R, 

SL_SLEEPSYS_C0_R, SL_SLEEPSYS_C1_R, SL_SLEEPSYS_C2_R, SL_SLEEPSYS_C3_R, 



SL_SLEEPBUS_C0_BR, SL_SLEEPBUS_C1_BR, SL_SLEEPBUS_C2_BR, SL_SLEEPBUS_C3_BR, 







SEN_N, TMODE_N, 


RESET_D1_R_N, 

RESET_D1_BR_N, 






RESET_D1_C1_R_N, RESET_D1_C1_BR_N, 

RESET_PWRON_C1_N, RESET_PWRON_D1_LR_N, 




JTAG_RST_N, 

RESET_N, RESET_PWRON_N, EJC_ECRPRRST_R 

); 


`include "../include/lxr_symbols.vh" 

input SYSCLKF; 




input BUSCLKF; 



input CFG_SLEEPENABLE; 
input [`HALT_SIG_RANGE] X_HALT_R; 
input CP0_SLEEP_M_R; 
input SYS_WBEMPTY_W_R; 
input EJC_DINT_R; 
input [7:2] INTREQ_N; 

input [7:0] CP0_IM_W_R; 

input EXT_SLEEPREQ_R; 

output [`HALT_DRV_RANGE] SL_HALT_W_R; 

output SL_SLEEPSYS_C0_R; 
output SL_SLEEPSYS_C1_R; 
output SL_SLEEPSYS_C2_R; 
output SL_SLEEPSYS_C3_R; 



output SL_SLEEPBUS_C0_BR; 
output SL_SLEEPBUS_C1_BR; 
output SL_SLEEPBUS_C2_BR; 
output SL_SLEEPBUS_C3_BR; 






input SEN_N; 
input TMODE_N; 

input JTAG_RST_N; 

input RESET_N; 
input RESET_PWRON_N; 
input EJC_ECRPRRST_R; 

output RESET_D1_R_N; 
output RESET_D1_BR_N; 


output RESET_D1_C1_R_N; 
output RESET_D1_C1_BR_N; 
output RESET_PWRON_C1_N; 
output RESET_PWRON_D1_LR_N; 


wire RESET_D1_BR_N; 
wire RESET_D1_C1_R_N; 
wire RESET_D1_C1_BR_N; 
wire RESET_PWRON_C1_N; 
wire RESET_PWRON_D1_LR_N; 



reg RESET_D0_R_N; 
reg RESET_D1_R_N_int; 
reg RESET_D1_C1_R_N_int; 


reg RESET_D0_BR_N; 
reg RESET_D1_BR_N_int; 
reg RESET_D2_BR_N; 
reg RESET_D1_C1_BR_N_int; 


reg RESET_PWRON_D0_LR_N; 
reg RESET_PWRON_D1_LR_N_int; 





wire SL_SLEEPSYS_SCANDIS; 
wire SL_SLEEPBUS_SCANDIS; 
















reg RESET_X_R_N; 

always @ (posedge SYSCLKF) 



RESET_X_R_N <= RESET_D1_R_N; 



wire RESET_D2_R_N = RESET_X_R_N | ~TMODE_N; 







assign RESET_D1_R_N = RESET_D1_R_N_int; 
assign RESET_D1_BR_N = RESET_D1_BR_N_int; 
assign RESET_D1_C1_R_N = RESET_D1_C1_R_N_int; 
assign RESET_D1_C1_BR_N = RESET_D1_C1_BR_N_int; 
assign RESET_PWRON_C1_N = RESET_PWRON_N; 
assign RESET_PWRON_D1_LR_N = RESET_PWRON_D1_LR_N_int; 




wire all_resets = 
JTAG_RST_N & 
RESET_N & RESET_PWRON_N & ~EJC_ECRPRRST_R; 




















always @ (posedge SYSCLKF) 

begin 
RESET_D0_R_N <= all_resets; 
RESET_D1_R_N_int <= RESET_D0_R_N; 
RESET_D1_C1_R_N_int <= RESET_D0_R_N; 
end 



always @ (posedge BUSCLKF) 


begin 
RESET_D0_BR_N <= all_resets; 
RESET_D1_BR_N_int <= RESET_D0_BR_N; 
RESET_D2_BR_N <= RESET_D1_BR_N_int; 
RESET_D1_C1_BR_N_int <= RESET_D0_BR_N; 
RESET_PWRON_D0_LR_N <= RESET_PWRON_N; 
RESET_PWRON_D1_LR_N_int <= RESET_PWRON_D0_LR_N; 
end 











reg [`HALT_DRV_RANGE] SL_HALT_W_R; 
reg SL_SLEEPSYS_R; 
reg SL_SLEEPSYS_C0_R; 
reg SL_SLEEPSYS_C1_R; 
reg SL_SLEEPSYS_C2_R; 
reg SL_SLEEPSYS_C3_R; 
reg SL_SLEEPBUS_BR; 

reg SL_SLEEPBUS_C0_BR; 
reg SL_SLEEPBUS_C1_BR; 
reg SL_SLEEPBUS_C2_BR; 
reg SL_SLEEPBUS_C3_BR; 

wire SL_SLEEPSYS_P; 

reg SL_SLEEPBUS_SE2_BR; 
reg SL_SLEEPBUS_E1_BR; 

















parameter ST_IDLE = 4'd0; 
parameter ST_HALT = 4'd1; 
parameter ST_COOL = 4'd2; 
parameter ST_CHILL1 = 4'd3; 
parameter ST_CHILL2 = 4'd4; 
parameter ST_CHILL3 = 4'd5; 
parameter ST_CHILL4 = 4'd6; 
parameter ST_CHILL5 = 4'd7; 
parameter ST_COLD = 4'd8; 
parameter ST_FROZEN = 4'd9; 
parameter ST_THAW = 4'd10; 

reg [3:0] ST_P, ST_R; 



assign SL_SLEEPSYS_SCANDIS = (SL_SLEEPSYS_R & (SEN_N & TMODE_N)); 
assign SL_SLEEPBUS_SCANDIS = (SL_SLEEPBUS_BR & (SEN_N & TMODE_N)); 



wire anyHalt = | (X_HALT_R & ~`RALU_HALT_E_MASK); 
wire otherHalt = | (X_HALT_R & ~`RALU_HALT_E_MASK & ~`DC_HALT_M_MASK & ~`SL_HALT_W_MASK); 



reg EXT_SLEEPREQ_D1_R; 
reg EXTSNOOZE_R; 
wire EXTSNOOZE_P; 



wire INTPEND_P; 
reg INTPEND_R; 
reg INTPEND_D1_R; 

assign INTPEND_P = | (CP0_IM_W_R[7:2] & ~INTREQ_N[7:2]) | EJC_DINT_R; 




wire WAKEUP = EXTSNOOZE_R ? ~EXT_SLEEPREQ_D1_R : INTPEND_D1_R; 

assign EXTSNOOZE_P = ( ST_R == ST_IDLE ) ? EXT_SLEEPREQ_D1_R : EXTSNOOZE_R; 



wire [ `HALT_DRV_RANGE] SL_HALT_W_P = { `HALT_DRV_COUNT { ST_P != ST_IDLE } }; 

assign SL_SLEEPSYS_P = ST_P == ST_FROZEN; 













































































wire CFG_SLEEPENABLE_C1 = CFG_SLEEPENABLE; 

always @ (ST_R or CP0_SLEEP_M_R or EXT_SLEEPREQ_D1_R or anyHalt or otherHalt or SYS_WBEMPTY_W_R or WAKEUP or CFG_SLEEPENABLE_C1) 

case (ST_R) 

ST_IDLE: ST_P = ((CP0_SLEEP_M_R | EXT_SLEEPREQ_D1_R) & ~anyHalt & CFG_SLEEPENABLE_C1) ? ST_HALT : ST_IDLE; 

ST_HALT: ST_P = ST_COOL; 

ST_COOL: ST_P = otherHalt ? ST_COOL : ST_CHILL1; 

ST_CHILL1: ST_P = ST_CHILL2; 

ST_CHILL2: ST_P = ST_CHILL3; 

ST_CHILL3: ST_P = ST_CHILL4; 

ST_CHILL4: ST_P = ST_CHILL5; 

ST_CHILL5: ST_P = ST_COLD; 

ST_COLD: ST_P = SYS_WBEMPTY_W_R ? ST_FROZEN : ST_COLD; 

ST_FROZEN: ST_P = WAKEUP ? ST_THAW : ST_FROZEN; 

ST_THAW: ST_P = ST_IDLE; 

endcase 







always @ (posedge SYSCLKF `negedge_RESET_D2_R_N_) 

if (~`RESET_D2_R_N_) 
begin 
ST_R <= ST_IDLE; 
SL_HALT_W_R <= { `HALT_DRV_COUNT { 1'b0 } }; 
SL_SLEEPSYS_R <= 1'b0; 
SL_SLEEPSYS_C1_R <= 1'b0; 
INTPEND_R <= 1'b0; 
INTPEND_D1_R <= 1'b0; 
EXT_SLEEPREQ_D1_R <= 1'b0; 
EXTSNOOZE_R <= 1'b0; 
SL_SLEEPSYS_C0_R <= 1'b0; 
SL_SLEEPSYS_C1_R <= 1'b0; 
SL_SLEEPSYS_C2_R <= 1'b0; 
SL_SLEEPSYS_C3_R <= 1'b0; 
end 
else 
begin 
ST_R <= ST_P; 
SL_HALT_W_R <= SL_HALT_W_P; 
SL_SLEEPSYS_R <= SL_SLEEPSYS_P; 
SL_SLEEPSYS_C1_R <= SL_SLEEPSYS_P; 
INTPEND_R <= INTPEND_P; 
INTPEND_D1_R <= INTPEND_R; 
EXT_SLEEPREQ_D1_R <= EXT_SLEEPREQ_R; 
EXTSNOOZE_R <= EXTSNOOZE_P; 
SL_SLEEPSYS_C0_R <= SL_SLEEPSYS_P; 
SL_SLEEPSYS_C1_R <= SL_SLEEPSYS_P; 
SL_SLEEPSYS_C2_R <= SL_SLEEPSYS_P; 
SL_SLEEPSYS_C3_R <= SL_SLEEPSYS_P; 
end 





always @ (posedge BUSCLKF `negedge_RESET_D2_BR_N_) 

if (~`RESET_D2_BR_N_) 

begin 
SL_SLEEPBUS_SE2_BR <= 1'b0; 
SL_SLEEPBUS_E1_BR <= 1'b0; 
SL_SLEEPBUS_BR <= 1'b0; 
SL_SLEEPBUS_C1_BR <= 1'b0; 
SL_SLEEPBUS_C0_BR <= 1'b0; 
SL_SLEEPBUS_C1_BR <= 1'b0; 
SL_SLEEPBUS_C2_BR <= 1'b0; 
SL_SLEEPBUS_C3_BR <= 1'b0; 
end 
else 
begin 
SL_SLEEPBUS_SE2_BR <= SL_SLEEPSYS_C1_R; 
SL_SLEEPBUS_E1_BR <= SL_SLEEPBUS_SE2_BR; 
SL_SLEEPBUS_BR <= SL_SLEEPBUS_E1_BR; 
SL_SLEEPBUS_C1_BR <= SL_SLEEPBUS_E1_BR; 
SL_SLEEPBUS_C0_BR <= SL_SLEEPBUS_E1_BR; 
SL_SLEEPBUS_C1_BR <= SL_SLEEPBUS_E1_BR; 
SL_SLEEPBUS_C2_BR <= SL_SLEEPBUS_E1_BR; 
SL_SLEEPBUS_C3_BR <= SL_SLEEPBUS_E1_BR; 
end 






endmodule 