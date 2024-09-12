set PDK_DIR $env(BASE_DIR)/libraries/SAED32
set LIB_DIR $PDK_DIR/lib/stdcell_hvt/db_nldm
set LEF_DIR $PDK_DIR/lib/stdcell_hvt/lef
set CAP_DIR $PDK_DIR/tech/cadence
set QRC_DIR $CAP_DIR/techgen

set fast_db [list $LIB_DIR/saed32hvt_dlvl_ff1p16vn40c_i1p16v.db \
                  $LIB_DIR/saed32hvt_ff1p16vn40c.db \
                  $LIB_DIR/saed32hvt_pg_ff1p16vn40c.db \
                  $LIB_DIR/saed32hvt_ulvl_ff1p16vn40c_i1p16v.db \
]
set slow_db [list $LIB_DIR/saed32hvt_dlvl_ss0p7v125c_i0p7v.db \
                  $LIB_DIR/saed32hvt_pg_ss0p7v125c.db \
                  $LIB_DIR/saed32hvt_ss0p7v125c.db \
                  $LIB_DIR/saed32hvt_ulvl_ss0p7v125c_i0p7v.db \
]
set typical_db [list $LIB_DIR/saed32hvt_dlvl_tt0p85v25c_i0p85v.db \
                     $LIB_DIR/saed32hvt_pg_tt0p85v25c.db \
                     $LIB_DIR/saed32hvt_tt0p85v25c.db \
                     $LIB_DIR/saed32hvt_ulvl_tt0p85v25c_i0p85v.db \
]

set fast_lib [list $LIB_DIR/saed32hvt_dlvl_ff1p16vn40c_i1p16v.lib \
                   $LIB_DIR/saed32hvt_ff1p16vn40c.lib \
                   $LIB_DIR/saed32hvt_pg_ff1p16vn40c.lib \
                   $LIB_DIR/saed32hvt_ulvl_ff1p16vn40c_i1p16v.lib \
]
set slow_lib [list $LIB_DIR/saed32hvt_dlvl_ss0p7v125c_i0p7v.lib \
                   $LIB_DIR/saed32hvt_pg_ss0p7v125c.lib \
                   $LIB_DIR/saed32hvt_ss0p7v125c.lib \
                   $LIB_DIR/saed32hvt_ulvl_ss0p7v125c_i0p7v.lib \
]
set typical_lib [list $LIB_DIR/saed32hvt_dlvl_tt0p85v25c_i0p85v.lib \
                      $LIB_DIR/saed32hvt_pg_tt0p85v25c.lib \
                      $LIB_DIR/saed32hvt_tt0p85v25c.lib \
                      $LIB_DIR/saed32hvt_ulvl_tt0p85v25c_i0p85v.lib \
]

set lef_files [list $CAP_DIR/saed32nm_1p9m_mw.v12.tech.lef \
                    $LEF_DIR/saed32nm_hvt_1p9m.lef ]

set qrc_tech_file "$QRC_DIR/qrcTechFile"
set cap_tbl_file "$CAP_DIR/saed32nm_1p9m_nominal.capTbl"



set BUF_CELLS [list TNBUFFX2_HVT TNBUFFX4_HVT TNBUFFX8]
set CLKBUF_CELLS [list TNBUFFX4_HVT TNBUFFX8_HVT TNBUFFX32_HVT]
set CLKGT_CELLS [list CGLPPSX2_HVT CGLPPSX8_HVT CGLPPSX16_HVT CGNLPSX2_HVT CGNLPSX8_HVT CGNLPSX16_HVT CGLPPRX2_HVT CGLPPRX8_HVT]
set INV_CELLS [list INVX0_HVT INVX2_HVT INVX8_HVT INVX32_HVT]
set FILL_CELLS [list SHFILL1_HVT SHFILL2_HVT SHFILL3_HVT SHFILL64_HVT DHFILLUP1_HVT DHFILLDN1_HVT DHFILLAO1_HVT]
