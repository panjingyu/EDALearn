#------------------------------------------------------------------------------
# Library Setup
#------------------------------------------------------------------------------

set PDK_DIR $env(BASE_DIR)/libraries/ASAP7
set STDLIB_DIR $PDK_DIR/asap7sc6t_26
set LIB_DIR $STDLIB_DIR/LIB/CCS
set LEF_DIR $STDLIB_DIR/LEF
set QRC_DIR $STDLIB_DIR/qrc

set fast_db [list $LIB_DIR/asap7sc6t_AO_LVT_FF_ccs_211010.db \
    $LIB_DIR/asap7sc6t_CKINVDC_LVT_FF_ccs_211010.db \
    $LIB_DIR/asap7sc6t_INVBUF_LVT_FF_ccs_211010.db \
    $LIB_DIR/asap7sc6t_OA_LVT_FF_ccs_211010.db \
    $LIB_DIR/asap7sc6t_SEQ_LVT_FF_ccs_211010.db \
    $LIB_DIR/asap7sc6t_SIMPLE_LVT_FF_ccs_211010.db ]

set slow_db [list $LIB_DIR/asap7sc6t_AO_LVT_SS_ccs_211010.db \
    $LIB_DIR/asap7sc6t_CKINVDC_LVT_SS_ccs_211010.db \
    $LIB_DIR/asap7sc6t_INVBUF_LVT_SS_ccs_211010.db \
    $LIB_DIR/asap7sc6t_OA_LVT_SS_ccs_211010.db \
    $LIB_DIR/asap7sc6t_SEQ_LVT_SS_ccs_211010.db \
    $LIB_DIR/asap7sc6t_SIMPLE_LVT_SS_ccs_211010.db ]

set typical_db [list $LIB_DIR/asap7sc6t_AO_LVT_TT_ccs_211010.db \
    $LIB_DIR/asap7sc6t_CKINVDC_LVT_TT_ccs_211010.db \
    $LIB_DIR/asap7sc6t_INVBUF_LVT_TT_ccs_211010.db \
    $LIB_DIR/asap7sc6t_OA_LVT_TT_ccs_211010.db \
    $LIB_DIR/asap7sc6t_SEQ_LVT_TT_ccs_211010.db \
    $LIB_DIR/asap7sc6t_SIMPLE_LVT_TT_ccs_211010.db ]

set fast_lib [list $LIB_DIR/asap7sc6t_AO_LVT_FF_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_CKINVDC_LVT_FF_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_INVBUF_LVT_FF_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_OA_LVT_FF_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_SEQ_LVT_FF_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_SIMPLE_LVT_FF_ccs_211010.lib ]

set slow_lib [list $LIB_DIR/asap7sc6t_AO_LVT_SS_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_CKINVDC_LVT_SS_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_INVBUF_LVT_SS_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_OA_LVT_SS_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_SEQ_LVT_SS_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_SIMPLE_LVT_SS_ccs_211010.lib ]

set typical_lib [list $LIB_DIR/asap7sc6t_AO_LVT_TT_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_CKINVDC_LVT_TT_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_INVBUF_LVT_TT_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_OA_LVT_TT_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_SEQ_LVT_TT_ccs_211010.lib \
    $LIB_DIR/asap7sc6t_SIMPLE_LVT_TT_ccs_211010.lib ]

set asap_lef [list $LEF_DIR/asap7sc6t_26_L_1x_210923b.lef \
    $STDLIB_DIR/techlef_misc/asap7sc6t_tech_4x_210831.lef]


set qrc_tech_file "$QRC_DIR/qrcTechFile_typ03_scaled4xV06"