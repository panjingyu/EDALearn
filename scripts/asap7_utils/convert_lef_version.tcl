# use icc2_lm_shell

set ASAP7_LIB_DIR libraries/ASAP7/asap7sc6t_26
set tech_lef $ASAP7_LIB_DIR/techlef_misc/asap7sc6t_tech_4x_210831.lef
set cell_lef $ASAP7_LIB_DIR/LEF/asap7sc6t_26_L_1x_210923b.lef

create_workspace ICC2_LM_WORK
# read_tech_lef $tech_lef
read_tech_file TEST.tf
read_lef $cell_lef -library asap7sc6t
write_lef $cell_lef.v5_6.lef -library asap7sc6t

exit
