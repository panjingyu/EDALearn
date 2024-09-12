set ASAP7_LIB_DIR libraries/ASAP7/asap7sc6t_26
read_lef -lib_name TEST -tech_lef_files $ASAP7_LIB_DIR/techlef_misc/asap7sc6t_tech_4x_210831.lef \
    -cell_lef_files $ASAP7_LIB_DIR/LEF/asap7sc6t_26_L_1x_210923b.lef
# cmDumpTech
# setFormField "Dump Technology File" "Library Name" "TEST"
# setFormField "Dump Technology File" "Technology File Name" "TEST.tf"
# formOK "Dump Technology File"

# Export the technology LEF file with version 5.6
# read_lef $ASAP7_LIB_DIR/techlef_misc/asap7sc6t_tech_4x_210831.lef
write_lef -lib_name TEST -output_version 5.6 -ignore_cell_info $ASAP7_LIB_DIR/techlef_misc/asap7sc6t_tech_4x_210831_v5_6.lef

# Export the cell LEF file with version 5.6
# read_lef $ASAP7_LIB_DIR/LEF/asap7sc6t_26_L_1x_210923b.lef
write_lef -lib_name TEST -output_version 5.6 -ignore_tech_info $ASAP7_LIB_DIR/LEF/asap7sc6t_26_L_1x_210923b_v5_6.lef

exit