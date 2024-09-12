module tag_array_ext(
  input  [5:0]  RW0_addr,
  input         RW0_clk,
  input  [87:0] RW0_wdata,
  output [87:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode,
  input  [3:0]  RW0_wmask
);
freepdk45_sram_1rw0r_64x88_22 mem_0 (
  .clk0(RW0_clk),
  .addr0(RW0_addr),
  .wmask0(RW0_wmask),
  .din0(RW0_wdata),
  .dout0(RW0_rdata),
  .csb0(~RW0_en),
  .web0(~RW0_wmode)
);
endmodule
module array_0_0_ext(
  input  [8:0]  W0_addr,
  input         W0_clk,
  input  [63:0] W0_data,
  input         W0_en,
  input         W0_mask,
  input  [8:0]  R0_addr,
  input         R0_clk,
  output [63:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_512x64_64 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~(W0_en & W0_mask)),
  // no wmask
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module tag_array_0_ext(
  input  [5:0]  RW0_addr,
  input         RW0_clk,
  input  [79:0] RW0_wdata,
  output [79:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode,
  input  [3:0]  RW0_wmask
);
freepdk45_sram_1rw0r_64x80_20 mem_0 (
  .clk0(RW0_clk),
  .addr0(RW0_addr),
  .wmask0(RW0_wmask),
  .din0(RW0_wdata),
  .dout0(RW0_rdata),
  .csb0(~RW0_en),
  .web0(~RW0_wmode)
);
endmodule
module dataArrayWay_0_ext(
  input  [8:0]  RW0_addr,
  input         RW0_clk,
  input  [63:0] RW0_wdata,
  output [63:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
freepdk45_sram_1rw0r_512x64 mem_0 (
  .clk0(RW0_clk),
  .addr0(RW0_addr),
  // no wmask
  .din0(RW0_wdata),
  .dout0(RW0_rdata),
  .csb0(~RW0_en),
  .web0(~RW0_wmode)
);
endmodule
module hi_us_ext(
  input  [6:0] W0_addr,
  input        W0_clk,
  input  [3:0] W0_data,
  input        W0_en,
  input  [3:0] W0_mask,
  input  [6:0] R0_addr,
  input        R0_clk,
  output [3:0] R0_data,
  input        R0_en
);
freepdk45_sram_1w1r_128x4_1 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module table_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [43:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [43:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_128x44_11 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module hi_us_0_ext(
  input  [7:0] W0_addr,
  input        W0_clk,
  input  [3:0] W0_data,
  input        W0_en,
  input  [3:0] W0_mask,
  input  [7:0] R0_addr,
  input        R0_clk,
  output [3:0] R0_data,
  input        R0_en
);
freepdk45_sram_1w1r_256x4_1 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module table_0_ext(
  input  [7:0]  W0_addr,
  input         W0_clk,
  input  [47:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [7:0]  R0_addr,
  input         R0_clk,
  output [47:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_256x48_12 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module table_1_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [51:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [51:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_128x52_13 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module meta_0_ext(
  input  [6:0]   W0_addr,
  input          W0_clk,
  input  [123:0] W0_data,
  input          W0_en,
  input  [3:0]   W0_mask,
  input  [6:0]   R0_addr,
  input          R0_clk,
  output [123:0] R0_data,
  input          R0_en
);
freepdk45_sram_1w1r_128x124_31 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module btb_0_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [55:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [55:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_128x56_14 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module ebtb_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [39:0] W0_data,
  input         W0_en,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [39:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_128x40 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  // no wmask
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module data_ext(
  input  [10:0] W0_addr,
  input         W0_clk,
  input  [7:0]  W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [10:0] R0_addr,
  input         R0_clk,
  output [7:0]  R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_2048x8_2 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  .wmask0(W0_mask),
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module meta_ext(
  input  [3:0]   W0_addr,
  input          W0_clk,
  input  [119:0] W0_data,
  input          W0_en,
  input  [3:0]   R0_addr,
  input          R0_clk,
  output [119:0] R0_data,
  input          R0_en
);
freepdk45_sram_1w1r_16x120 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  // no wmask
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module ghist_0_ext(
  input  [3:0]  W0_addr,
  input         W0_clk,
  input  [71:0] W0_data,
  input         W0_en,
  input  [3:0]  R0_addr,
  input         R0_clk,
  output [71:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_16x72 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~W0_en),
  // no wmask
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module rob_debug_inst_mem_ext(
  input  [4:0]  W0_addr,
  input         W0_clk,
  input  [31:0] W0_data,
  input         W0_en,
  input         W0_mask,
  input  [4:0]  R0_addr,
  input         R0_clk,
  output [31:0] R0_data,
  input         R0_en
);
freepdk45_sram_1w1r_32x32_32 mem_0 (
  // Port 0: W
  .clk0(W0_clk),
  .addr0(W0_addr),
  .din0(W0_data),
  .csb0(~(W0_en & W0_mask)),
  // no wmask
  // Port 1: R
  .clk1(R0_clk),
  .addr1(R0_addr),
  .dout1(R0_data),
  .csb1(~R0_en)
);
endmodule
module l2_tlb_ram_ext(
  input  [8:0]  RW0_addr,
  input         RW0_clk,
  input  [44:0] RW0_wdata,
  output [44:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
freepdk45_sram_1rw0r_512x45 mem_0 (
  .clk0(RW0_clk),
  .addr0(RW0_addr),
  // no wmask
  .din0(RW0_wdata),
  .dout0(RW0_rdata),
  .csb0(~RW0_en),
  .web0(~RW0_wmode)
);
endmodule
