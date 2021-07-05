create_project -part xc7z020-1clg400 rtl.xpr rtl-proj -force

set_property ip_repo_paths hls-proj [current_project]
update_ip_catalog

create_bd_design overlay
open_bd_design overlay

# Create interface ports
set ps [ create_bd_cell -vlnv xilinx.com:ip:processing_system7 ps ]
set_property -dict [ list \
  CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
  CONFIG.PCW_USE_S_AXI_HP0 {1} \
  CONFIG.PCW_USE_S_AXI_HP1 {1} \
] $ps
  
create_bd_cell -vlnv xilinx.com:ip:proc_sys_reset sys_rst
create_bd_cell -vlnv xilinx.com:hls:gesture_accel gesture_accel


set axi_ic0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic0 ]

set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
] $axi_ic0

set axi_ic1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic1 ]
set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
] $axi_ic1

set axi_ic2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic2 ]
set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
] $axi_ic2


save_bd_design

# interconnect - buses
apply_bd_automation \
	-rule xilinx.com:bd_rule:processing_system7 \
	-config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" } \
	[get_bd_cells ps]

connect_bd_intf_net -intf_net axi_ic0_M00_AXI [get_bd_intf_pins axi_ic0/M00_AXI] [get_bd_intf_pins gesture_accel/s_axi_control]
connect_bd_intf_net -intf_net ps_M_AXI_GP0 [get_bd_intf_pins axi_ic0/S00_AXI] [get_bd_intf_pins ps/M_AXI_GP0]

connect_bd_intf_net -intf_net axi_ic1_M00_AXI [get_bd_intf_pins axi_ic1/M00_AXI] [get_bd_intf_pins ps/S_AXI_HP0]
connect_bd_intf_net -intf_net gesture_accel_m_axi_gmem1 [get_bd_intf_pins axi_ic1/S00_AXI] [get_bd_intf_pins gesture_accel/m_axi_gmem1]
connect_bd_intf_net -intf_net gesture_accel_m_axi_gmem2 [get_bd_intf_pins axi_ic1/S01_AXI] [get_bd_intf_pins gesture_accel/m_axi_gmem2]

connect_bd_intf_net -intf_net axi_ic2_M00_AXI [get_bd_intf_pins axi_ic2/M00_AXI] [get_bd_intf_pins ps/S_AXI_HP1]
connect_bd_intf_net -intf_net gesture_accel_m_axi_gmem3 [get_bd_intf_pins axi_ic2/S00_AXI] [get_bd_intf_pins gesture_accel/m_axi_gmem3]
connect_bd_intf_net -intf_net gesture_accel_m_axi_gmem4 [get_bd_intf_pins axi_ic2/S01_AXI] [get_bd_intf_pins gesture_accel/m_axi_gmem4]


# Create port connections
connect_bd_net -net ps_FCLK_CLK0 [get_bd_pins axi_ic0/ACLK] [get_bd_pins axi_ic0/M00_ACLK] [get_bd_pins axi_ic0/S00_ACLK] \
[get_bd_pins axi_ic1/ACLK] [get_bd_pins axi_ic1/M00_ACLK] [get_bd_pins axi_ic1/S00_ACLK] [get_bd_pins axi_ic1/S01_ACLK] \
[get_bd_pins axi_ic2/ACLK] [get_bd_pins axi_ic2/M00_ACLK] [get_bd_pins axi_ic2/S00_ACLK] [get_bd_pins axi_ic2/S01_ACLK] \
[get_bd_pins ps/FCLK_CLK0] [get_bd_pins ps/M_AXI_GP0_ACLK] [get_bd_pins ps/S_AXI_HP0_ACLK] [get_bd_pins ps/S_AXI_HP1_ACLK] \
[get_bd_pins gesture_accel/ap_clk] \
[get_bd_pins sys_rst/slowest_sync_clk]

connect_bd_net -net ps_FCLK_RESET0_N [get_bd_pins ps/FCLK_RESET0_N] [get_bd_pins sys_rst/ext_reset_in]

connect_bd_net -net sys_rst_peripheral_aresetn [get_bd_pins axi_ic0/ARESETN] [get_bd_pins axi_ic0/M00_ARESETN] \
[get_bd_pins axi_ic0/S00_ARESETN] [get_bd_pins axi_ic1/ARESETN] [get_bd_pins axi_ic1/M00_ARESETN] \
[get_bd_pins axi_ic2/ARESETN] [get_bd_pins axi_ic2/M00_ARESETN] \
[get_bd_pins axi_ic1/S00_ARESETN] [get_bd_pins axi_ic1/S01_ARESETN] [get_bd_pins gesture_accel/ap_rst_n] \
[get_bd_pins axi_ic2/S00_ARESETN] [get_bd_pins axi_ic2/S01_ARESETN] \
[get_bd_pins sys_rst/peripheral_aresetn]

save_bd_design
# Address segments

assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces gesture_accel/Data_m_axi_gmem1] [get_bd_addr_segs ps/S_AXI_HP0/HP0_DDR_LOWOCM]
assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces gesture_accel/Data_m_axi_gmem2] [get_bd_addr_segs ps/S_AXI_HP0/HP0_DDR_LOWOCM]
assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces gesture_accel/Data_m_axi_gmem3] [get_bd_addr_segs ps/S_AXI_HP1/HP1_DDR_LOWOCM]
assign_bd_address -offset 0x00000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces gesture_accel/Data_m_axi_gmem4] [get_bd_addr_segs ps/S_AXI_HP1/HP1_DDR_LOWOCM]
assign_bd_address -range 0x00010000 -offset 0x43C00000 \
	[get_bd_addr_spaces ps/Data] [get_bd_addr_segs gesture_accel/s_axi_control/Reg]
save_bd_design
set_property top overlay [current_fileset]


launch_runs impl_1 -to_step write_bitstream                                                                          
wait_on_run impl_1                                                                                                   
exit
