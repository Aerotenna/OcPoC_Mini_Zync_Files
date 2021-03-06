
################################################################
# This is a generated script based on design: armps
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source armps_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z010clg400-1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name armps

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set CAN_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:can_rtl:1.0 CAN_0 ]
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set IIC_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_0 ]
  set IIC_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_1 ]
  set SPI_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 SPI_0 ]
  set SPI_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 SPI_1 ]
  set UART_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 UART_0 ]
  set iic_rtl [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_rtl ]
  set uart_rtl0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_rtl0 ]
  set uart_rtl1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_rtl1 ]
  set uart_rtl2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_rtl2 ]
  set uart_rtl3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_rtl3 ]
  set uartlite [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uartlite ]

  # Create ports
  set freeze [ create_bd_port -dir I freeze ]
  set pwm_0 [ create_bd_port -dir O pwm_0 ]
  set pwm_1 [ create_bd_port -dir O pwm_1 ]
  set pwm_2 [ create_bd_port -dir O pwm_2 ]
  set pwm_3 [ create_bd_port -dir O pwm_3 ]
  set pwm_4 [ create_bd_port -dir O pwm_4 ]
  set pwm_5 [ create_bd_port -dir O pwm_5 ]
  set pwm_6 [ create_bd_port -dir O pwm_6 ]
  set pwm_7 [ create_bd_port -dir O pwm_7 ]

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_0 ]
  set_property -dict [ list \
CONFIG.IIC_FREQ_KHZ {400} \
 ] $axi_iic_0

  # Create instance: axi_uart16550_0, and set properties
  set axi_uart16550_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_uart16550_0 ]

  # Create instance: axi_uart16550_1, and set properties
  set axi_uart16550_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_uart16550_1 ]

  # Create instance: axi_uart16550_2, and set properties
  set axi_uart16550_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_uart16550_2 ]

  # Create instance: axi_uart16550_3, and set properties
  set axi_uart16550_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_uart16550_3 ]

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
CONFIG.C_BAUDRATE {115200} \
 ] $axi_uartlite_0

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET_RESET_ENABLE {0} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J128M16 HA-15E} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB_RESET_ENABLE {0} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE {1} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {7} \
 ] $processing_system7_0_axi_periph

  # Create instance: pwm_chan8_0, and set properties
  set pwm_chan8_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:pwm_chan8:1.0 pwm_chan8_0 ]

  # Create instance: rst_processing_system7_0_50M, and set properties
  set rst_processing_system7_0_50M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_50M ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_ports iic_rtl] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_uart16550_0_UART [get_bd_intf_ports uart_rtl0] [get_bd_intf_pins axi_uart16550_0/UART]
  connect_bd_intf_net -intf_net axi_uart16550_1_UART [get_bd_intf_ports uart_rtl1] [get_bd_intf_pins axi_uart16550_1/UART]
  connect_bd_intf_net -intf_net axi_uart16550_2_UART [get_bd_intf_ports uart_rtl2] [get_bd_intf_pins axi_uart16550_2/UART]
  connect_bd_intf_net -intf_net axi_uart16550_3_UART [get_bd_intf_ports uart_rtl3] [get_bd_intf_pins axi_uart16550_3/UART]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports uartlite] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net processing_system7_0_CAN_0 [get_bd_intf_ports CAN_0] [get_bd_intf_pins processing_system7_0/CAN_0]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_IIC_0 [get_bd_intf_ports IIC_0] [get_bd_intf_pins processing_system7_0/IIC_0]
  connect_bd_intf_net -intf_net processing_system7_0_IIC_1 [get_bd_intf_ports IIC_1] [get_bd_intf_pins processing_system7_0/IIC_1]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_SPI_0 [get_bd_intf_ports SPI_0] [get_bd_intf_pins processing_system7_0/SPI_0]
  connect_bd_intf_net -intf_net processing_system7_0_SPI_1 [get_bd_intf_ports SPI_1] [get_bd_intf_pins processing_system7_0/SPI_1]
  connect_bd_intf_net -intf_net processing_system7_0_UART_0 [get_bd_intf_ports UART_0] [get_bd_intf_pins processing_system7_0/UART_0]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI] [get_bd_intf_pins pwm_chan8_0/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_uart16550_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins axi_uart16550_1/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins axi_uart16550_2/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_uart16550_3/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]

  # Create port connections
  connect_bd_net -net freeze_1 [get_bd_ports freeze] [get_bd_pins axi_uart16550_0/freeze]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_uart16550_0/s_axi_aclk] [get_bd_pins axi_uart16550_1/s_axi_aclk] [get_bd_pins axi_uart16550_2/s_axi_aclk] [get_bd_pins axi_uart16550_3/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins pwm_chan8_0/s00_axi_aclk] [get_bd_pins rst_processing_system7_0_50M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_50M/ext_reset_in]
  connect_bd_net -net pwm_chan8_0_pwm0 [get_bd_ports pwm_0] [get_bd_pins pwm_chan8_0/pwm0]
  connect_bd_net -net pwm_chan8_0_pwm1 [get_bd_ports pwm_1] [get_bd_pins pwm_chan8_0/pwm1]
  connect_bd_net -net pwm_chan8_0_pwm2 [get_bd_ports pwm_2] [get_bd_pins pwm_chan8_0/pwm2]
  connect_bd_net -net pwm_chan8_0_pwm3 [get_bd_ports pwm_3] [get_bd_pins pwm_chan8_0/pwm3]
  connect_bd_net -net pwm_chan8_0_pwm4 [get_bd_ports pwm_4] [get_bd_pins pwm_chan8_0/pwm4]
  connect_bd_net -net pwm_chan8_0_pwm5 [get_bd_ports pwm_5] [get_bd_pins pwm_chan8_0/pwm5]
  connect_bd_net -net pwm_chan8_0_pwm6 [get_bd_ports pwm_6] [get_bd_pins pwm_chan8_0/pwm6]
  connect_bd_net -net pwm_chan8_0_pwm7 [get_bd_ports pwm_7] [get_bd_pins pwm_chan8_0/pwm7]
  connect_bd_net -net rst_processing_system7_0_50M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_50M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_50M_peripheral_aresetn [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_uart16550_0/s_axi_aresetn] [get_bd_pins axi_uart16550_1/s_axi_aresetn] [get_bd_pins axi_uart16550_2/s_axi_aresetn] [get_bd_pins axi_uart16550_3/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins pwm_chan8_0/s00_axi_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_uart16550_0/S_AXI/Reg] SEG_axi_uart16550_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_uart16550_1/S_AXI/Reg] SEG_axi_uart16550_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_uart16550_2/S_AXI/Reg] SEG_axi_uart16550_2_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_uart16550_3/S_AXI/Reg] SEG_axi_uart16550_3_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x42C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs pwm_chan8_0/S00_AXI/S00_AXI_reg] SEG_pwm_chan8_0_S00_AXI_reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port pwm_4 -pg 1 -y 610 -defaultsOSRD
preplace port iic_rtl -pg 1 -y 1030 -defaultsOSRD
preplace port uart_rtl1 -pg 1 -y 1170 -defaultsOSRD
preplace port DDR -pg 1 -y 60 -defaultsOSRD
preplace port pwm_5 -pg 1 -y 630 -defaultsOSRD
preplace port uart_rtl2 -pg 1 -y 1310 -defaultsOSRD
preplace port pwm_6 -pg 1 -y 650 -defaultsOSRD
preplace port uart_rtl3 -pg 1 -y 1450 -defaultsOSRD
preplace port pwm_7 -pg 1 -y 670 -defaultsOSRD
preplace port UART_0 -pg 1 -y 100 -defaultsOSRD
preplace port uartlite -pg 1 -y 920 -defaultsOSRD
preplace port IIC_0 -pg 1 -y 120 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 80 -defaultsOSRD
preplace port pwm_0 -pg 1 -y 530 -defaultsOSRD
preplace port SPI_0 -pg 1 -y 160 -defaultsOSRD
preplace port IIC_1 -pg 1 -y 140 -defaultsOSRD
preplace port freeze -pg 1 -y 730 -defaultsOSRD
preplace port pwm_1 -pg 1 -y 550 -defaultsOSRD
preplace port SPI_1 -pg 1 -y 180 -defaultsOSRD
preplace port pwm_2 -pg 1 -y 570 -defaultsOSRD
preplace port CAN_0 -pg 1 -y 200 -defaultsOSRD
preplace port pwm_3 -pg 1 -y 590 -defaultsOSRD
preplace port uart_rtl0 -pg 1 -y 790 -defaultsOSRD
preplace inst axi_uart16550_3 -pg 1 -lvl 3 -y 1460 -defaultsOSRD
preplace inst axi_iic_0 -pg 1 -lvl 3 -y 1050 -defaultsOSRD
preplace inst pwm_chan8_0 -pg 1 -lvl 3 -y 600 -defaultsOSRD
preplace inst rst_processing_system7_0_50M -pg 1 -lvl 1 -y 830 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 3 -y 930 -defaultsOSRD
preplace inst axi_uart16550_0 -pg 1 -lvl 3 -y 800 -defaultsOSRD
preplace inst axi_uart16550_1 -pg 1 -lvl 3 -y 1180 -defaultsOSRD
preplace inst axi_uart16550_2 -pg 1 -lvl 3 -y 1320 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 2 -y 970 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 3 -y 230 -defaultsOSRD
preplace netloc axi_uart16550_1_UART 1 3 1 NJ
preplace netloc processing_system7_0_DDR 1 3 1 NJ
preplace netloc pwm_chan8_0_pwm1 1 3 1 NJ
preplace netloc processing_system7_0_UART_0 1 3 1 NJ
preplace netloc pwm_chan8_0_pwm2 1 3 1 NJ
preplace netloc axi_uart16550_3_UART 1 3 1 NJ
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 2 1 690
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 2 1 650
preplace netloc pwm_chan8_0_pwm3 1 3 1 NJ
preplace netloc rst_processing_system7_0_50M_interconnect_aresetn 1 1 1 350
preplace netloc processing_system7_0_M_AXI_GP0 1 1 3 360 470 NJ 470 1060
preplace netloc pwm_chan8_0_pwm4 1 3 1 NJ
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 2 1 650
preplace netloc pwm_chan8_0_pwm5 1 3 1 NJ
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 4 20 480 NJ 480 NJ 480 1050
preplace netloc processing_system7_0_IIC_0 1 3 1 NJ
preplace netloc pwm_chan8_0_pwm6 1 3 1 NJ
preplace netloc rst_processing_system7_0_50M_peripheral_aresetn 1 1 2 350 1220 700
preplace netloc axi_uart16550_0_UART 1 3 1 NJ
preplace netloc processing_system7_0_IIC_1 1 3 1 NJ
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 2 1 670
preplace netloc pwm_chan8_0_pwm7 1 3 1 NJ
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 2 1 N
preplace netloc processing_system7_0_FIXED_IO 1 3 1 NJ
preplace netloc axi_iic_0_IIC 1 3 1 NJ
preplace netloc axi_uartlite_0_UART 1 3 1 NJ
preplace netloc freeze_1 1 0 3 NJ 730 NJ 730 NJ
preplace netloc processing_system7_0_FCLK_CLK0 1 0 4 30 920 360 1210 680 720 1070
preplace netloc processing_system7_0_SPI_0 1 3 1 NJ
preplace netloc processing_system7_0_CAN_0 1 3 1 NJ
preplace netloc axi_uart16550_2_UART 1 3 1 NJ
preplace netloc processing_system7_0_SPI_1 1 3 1 NJ
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 2 1 670
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 1 660
preplace netloc pwm_chan8_0_pwm0 1 3 1 NJ
levelinfo -pg 1 0 190 510 880 1090 -top 0 -bot 1540
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


