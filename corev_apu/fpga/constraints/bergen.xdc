#
# NewAE Technology Inc - CW310 Bergen Board XDC Constaints File.
#
# This file is released into the public domain, and has no distribution restrictions. However be aware
# there is NO WARRANTY and this file may have errors, the usage is at your own risk. Certain signals
# may not be sufficiently constrained, or incorrect constraints may be included herein.

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#####
# DIP Switches
#####
set_property -dict {PACKAGE_PIN U9 IOSTANDARD LVCMOS18} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS18} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS18} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN W9 IOSTANDARD LVCMOS18} [get_ports {sw[3]}]
set_property -dict {PACKAGE_PIN V9 IOSTANDARD LVCMOS18} [get_ports {sw[4]}]
set_property -dict {PACKAGE_PIN W8 IOSTANDARD LVCMOS18} [get_ports {sw[5]}]
set_property -dict {PACKAGE_PIN W10 IOSTANDARD LVCMOS18} [get_ports {sw[6]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS18} [get_ports {sw[7]}]

#####
# LEDs
#####
set_property -dict {PACKAGE_PIN M26 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN M25 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN M24 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {led[3]}]
set_property -dict {PACKAGE_PIN L25 IOSTANDARD LVCMOS33} [get_ports {led[4]}]
set_property -dict {PACKAGE_PIN K26 IOSTANDARD LVCMOS33} [get_ports {led[5]}]
set_property -dict {PACKAGE_PIN L24 IOSTANDARD LVCMOS33} [get_ports {led[6]}]
set_property -dict {PACKAGE_PIN K25 IOSTANDARD LVCMOS33} [get_ports {led[7]}]

#####
# Push-Button Switches
#####
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS18} [get_ports cpu_resetn]

#####
# Debug / JTAG user headers
#####
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports trst_n]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports tck]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports tdi]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports tdo]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports tms]

#####
# SAM3X SPI Interface
#####
set_property -dict {PACKAGE_PIN A22 IOSTANDARD LVCMOS33} [get_ports spi_miso]
set_property -dict {PACKAGE_PIN A24 IOSTANDARD LVCMOS33} [get_ports spi_mosi]
set_property -dict {PACKAGE_PIN C26 IOSTANDARD LVCMOS33} [get_ports spi_ss]
set_property -dict {PACKAGE_PIN D26 IOSTANDARD LVCMOS33} [get_ports spi_clk_o]

#####
# ChipWhisperer 20-pin header
#####
set_property -dict { PACKAGE_PIN AB21  IOSTANDARD   LVCMOS33 } [get_ports { clk_husky }]; #IO_L18P_T2_12
set_property -dict { PACKAGE_PIN AF24  IOSTANDARD   LVCMOS33 } [get_ports { trigger }]; #IO_L20P_T3_12

#####
# SAM3X UART/USART Interface (Serial Console)
#####
set_property -dict { PACKAGE_PIN AB22  IOSTANDARD   LVCMOS33 } [get_ports { rx }];
set_property -dict { PACKAGE_PIN AA24  IOSTANDARD   LVCMOS33 } [get_ports { tx }];

# accept sub-optimal placement
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets tck_IBUF]

## DDR3 configuration
set_property -dict {PACKAGE_PIN N24 IOSTANDARD LVCMOS33} [get_ports vddr_enable]
set_property -dict {PACKAGE_PIN AB7 IOSTANDARD LVCMOS18} [get_ports LVDS_XO_200M_ENA]

# Bergen CW310 has a quad SPI flash
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

## JTAG
# minimize routing delay
set_max_delay -to [get_ports tdo] 20.000
set_max_delay -from [get_ports tms] 20.000
set_max_delay -from [get_ports tdi] 20.000
set_max_delay -from [get_ports trst_n] 20.000

# reset signal
set_false_path -from [get_ports trst_n]
set_false_path -from [get_pins i_ddr/u_xlnx_mig_7_ddr3_mig/u_ddr3_infrastructure/rstdiv0_sync_r1_reg_rep/C]

# timing constraint
create_clock -name clk_husky -period 20.000 [get_ports clk_husky]
