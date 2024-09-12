#------------------------------------------------------------------------------
# Library Setup
#------------------------------------------------------------------------------

set PDK_DIR $env(BASE_DIR)/libraries/FreePDK45
set STDLIB_DIR $PDK_DIR/NangateOpenCellLibrary_PDKv1_3_v2010_12
set DB_DIR $STDLIB_DIR/db
set LIB_DIR $STDLIB_DIR/Front_End/Liberty/CCS
set LEF_DIR $STDLIB_DIR/Back_End/lef
set CAP_DIR $STDLIB_DIR

set fast_db [list $DB_DIR/fast.db]
set slow_db [list $DB_DIR/slow.db]
set typical_db [list $DB_DIR/typical.db]

set fast_lib [list $LIB_DIR/NangateOpenCellLibrary_fast_ccs.lib]
set slow_lib [list $LIB_DIR/NangateOpenCellLibrary_slow_ccs.lib]
set typical_lib [list $LIB_DIR/NangateOpenCellLibrary_typical_ccs.lib]

set nangate_lef [list $LEF_DIR/NangateOpenCellLibrary.lef]

set cap_tbl_file "$CAP_DIR/NCSU_FreePDK_45nm.capTbl"

set BUF_CELLS [list BUF_X1  BUF_X2  BUF_X4  BUF_X8  BUF_X16 BUF_X32]
set CLKBUF_CELLS [list CLKBUF_X1 CLKBUF_X2 CLKBUF_X3]
set CLKGT_CELLS [list CLKGATE_X1 CLKGATE_X2 CLKGATE_X4 CLKGATE_X8]
set INV_CELLS [list INV_X1  INV_X2  INV_X4  INV_X8  INV_X16  INV_X32]
set FILL_CELLS [list FILLCELL_X1  FILLCELL_X2  FILLCELL_X4  FILLCELL_X8  FILLCELL_X16  FILLCELL_X32]


#------------------------------------------------------------------------------
# OpenRAM Setup
#------------------------------------------------------------------------------
set OPENRAM_MACRO_DB_DIR $PDK_DIR/OpenRAM/db
set OPENRAM_MACRO_LIB_DIR $PDK_DIR/OpenRAM/lib
set OPENRAM_MACRO_LEF_DIR $PDK_DIR/OpenRAM/lef

set openram_db(slow) [list \
    freepdk45_sram_1rw0r_1024x136_17_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_128x44_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_20x64_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_22x64_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_256x64_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_45x512_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_512x45_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_512x64_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x160_20_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x176_22_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x20_64_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x40_20_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x44_22_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x512_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x80_20_SS_0p95V_125C.db \
    freepdk45_sram_1rw0r_64x88_22_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_120x16_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x120_30_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x124_31_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x32_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x40_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x44_11_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x4_1_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x52_13_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_128x56_14_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_16x120_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_16x32_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_16x72_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_2048x8_2_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_256x128_64_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_256x48_12_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_256x4_1_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_27x96_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_28x128_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_31x128_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x120_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x128_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x240_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x32_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x64_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x72_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_32x96_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_34x128_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_38x96_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_40x128_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_40x240_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_40x64_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_40x72_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_48x32_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_512x64_64_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_64x32_32_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_64x512_SS_0p95V_125C.db \
    freepdk45_sram_1w1r_96x32_32_SS_0p95V_125C.db \
]

set openram_db(typical) [list \
    freepdk45_sram_1rw0r_1024x136_17_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_128x44_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_20x64_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_22x64_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_256x64_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_45x512_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_512x45_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_512x64_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x160_20_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x176_22_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x20_64_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x40_20_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x44_22_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x512_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x80_20_TT_1p1V_25C.db \
    freepdk45_sram_1rw0r_64x88_22_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_120x16_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x120_30_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x124_31_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x32_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x40_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x44_11_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x4_1_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x52_13_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_128x56_14_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_16x120_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_16x32_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_16x72_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_2048x8_2_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_256x128_64_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_256x48_12_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_256x4_1_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_27x96_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_28x128_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_31x128_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x120_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x128_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x240_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x32_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x64_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x72_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_32x96_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_34x128_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_38x96_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_40x128_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_40x240_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_40x64_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_40x72_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_48x32_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_512x64_64_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_64x32_32_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_64x512_TT_1p1V_25C.db \
    freepdk45_sram_1w1r_96x32_32_TT_1p1V_25C.db \
]

set openram_db(fast) [list \
    freepdk45_sram_1rw0r_1024x136_17_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_128x44_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_20x64_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_22x64_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_256x64_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_45x512_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_512x45_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_512x64_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x160_20_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x176_22_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x20_64_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x40_20_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x44_22_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x512_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x80_20_FF_1p25V_0C.db \
    freepdk45_sram_1rw0r_64x88_22_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_120x16_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x120_30_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x124_31_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x32_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x40_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x44_11_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x4_1_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x52_13_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_128x56_14_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_16x120_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_16x32_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_16x72_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_2048x8_2_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_256x128_64_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_256x48_12_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_256x4_1_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_27x96_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_28x128_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_31x128_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x120_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x128_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x240_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x32_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x64_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x72_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_32x96_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_34x128_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_38x96_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_40x128_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_40x240_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_40x64_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_40x72_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_48x32_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_512x64_64_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_64x32_32_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_64x512_FF_1p25V_0C.db \
    freepdk45_sram_1w1r_96x32_32_FF_1p25V_0C.db \
]

set openram_lib(slow) [list \
    freepdk45_sram_1rw0r_1024x136_17_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_128x44_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_20x64_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_22x64_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_256x64_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_45x512_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_512x45_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_512x64_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x160_20_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x176_22_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x20_64_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x40_20_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x44_22_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x512_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x80_20_SS_0p95V_125C.lib \
    freepdk45_sram_1rw0r_64x88_22_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_120x16_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x120_30_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x124_31_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x32_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x40_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x44_11_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x4_1_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x52_13_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_128x56_14_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_16x120_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_16x32_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_16x72_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_2048x8_2_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_256x128_64_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_256x48_12_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_256x4_1_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_27x96_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_28x128_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_31x128_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x120_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x128_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x240_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x32_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x64_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x72_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_32x96_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_34x128_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_38x96_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_40x128_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_40x240_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_40x64_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_40x72_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_48x32_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_512x64_64_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_64x32_32_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_64x512_SS_0p95V_125C.lib \
    freepdk45_sram_1w1r_96x32_32_SS_0p95V_125C.lib \
]

set openram_lib(typical) [list \
    freepdk45_sram_1rw0r_1024x136_17_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_128x44_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_20x64_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_22x64_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_256x64_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_45x512_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_512x45_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_512x64_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x160_20_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x176_22_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x20_64_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x40_20_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x44_22_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x512_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x80_20_TT_1p1V_25C.lib \
    freepdk45_sram_1rw0r_64x88_22_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_120x16_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x120_30_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x124_31_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x32_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x40_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x44_11_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x4_1_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x52_13_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_128x56_14_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_16x120_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_16x32_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_16x72_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_2048x8_2_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_256x128_64_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_256x48_12_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_256x4_1_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_27x96_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_28x128_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_31x128_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x120_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x128_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x240_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x32_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x64_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x72_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_32x96_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_34x128_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_38x96_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_40x128_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_40x240_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_40x64_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_40x72_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_48x32_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_512x64_64_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_64x32_32_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_64x512_TT_1p1V_25C.lib \
    freepdk45_sram_1w1r_96x32_32_TT_1p1V_25C.lib \
]

set openram_lib(fast) [list \
    freepdk45_sram_1rw0r_1024x136_17_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_128x44_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_20x64_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_22x64_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_256x64_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_45x512_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_512x45_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_512x64_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x160_20_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x176_22_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x20_64_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x40_20_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x44_22_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x512_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x80_20_FF_1p25V_0C.lib \
    freepdk45_sram_1rw0r_64x88_22_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_120x16_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x120_30_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x124_31_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x32_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x40_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x44_11_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x4_1_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x52_13_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_128x56_14_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_16x120_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_16x32_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_16x72_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_2048x8_2_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_256x128_64_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_256x48_12_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_256x4_1_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_27x96_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_28x128_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_31x128_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x120_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x128_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x240_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x32_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x64_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x72_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_32x96_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_34x128_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_38x96_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_40x128_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_40x240_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_40x64_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_40x72_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_48x32_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_512x64_64_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_64x32_32_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_64x512_FF_1p25V_0C.lib \
    freepdk45_sram_1w1r_96x32_32_FF_1p25V_0C.lib \
]

set openram_sram_lefs [list \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_1024x136_17.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_128x44.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_20x64.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_22x64.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_256x64.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_45x512.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_512x45.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_512x64.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x160_20.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x176_22.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x20_64.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x40_20.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x44_22.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x512.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x80_20.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1rw0r_64x88_22.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_11x128.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_120x16.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x120_30.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x124_31.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x32_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x40.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x44_11.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x4_1.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x52_13.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_128x56_14.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_12x256.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_13x128.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_14x128.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_16x120.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_16x32_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_16x72.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_2048x8_2.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_256x128_64.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_256x48_12.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_256x4_1.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_27x96_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_28x128_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_31x128.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x120.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x128_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x240.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x32_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x64_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x72.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_32x96_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_34x128_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_38x96_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_40x128.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_40x240.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_40x64_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_40x72.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_48x32_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_512x64_64.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_64x32_32.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_64x512.lef \
    $OPENRAM_MACRO_LEF_DIR/freepdk45_sram_1w1r_96x32_32.lef \
]

set lef_files [concat $nangate_lef $openram_sram_lefs]