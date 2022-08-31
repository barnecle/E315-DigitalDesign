
set MYFILE [file normalize [info script]]
set MYDIR  [file dirname ${MYFILE}]
set BASEDIR ${MYDIR}/../
set SRCDIR ${MYDIR}/../verilog/vsrc/
set TESTDIR ${MYDIR}/../verilog/vtests/ 

create_project -force vivado_project.xpr ${BASEDIR}/vivado_project -part xc7z020clg400-1

# add source files
add_files [glob ${SRCDIR}/*.v]
add_files [glob ${SRCDIR}/*.sv]

add_files ${SRCDIR}/design_fpga/design_fpga.bd
make_wrapper -files [get_files *.bd] -top
add_files ${SRCDIR}/design_fpga/hdl/design_fpga_wrapper.v 

# add testbenches
create_fileset -simset sim_bitflip
add_files -fileset sim_bitflip ${TESTDIR}/sim_bitflip/tb_bitflip.sv
add_files -fileset sim_bitflip ${TESTDIR}/sim_bitflip/bd_bitflip/bd_bitflip.bd
make_wrapper -files [get_files *.bd] -top
add_files -fileset sim_bitflip ${TESTDIR}/sim_bitflip/bd_bitflip/hdl/bd_bitflip_wrapper.v
add_files -fileset sim_bitflip ${TESTDIR}/sim_bitflip/tb_bitflip_behav.wcfg
set_property top tb_bitflip [get_filesets sim_bitflip]

create_fileset -simset sim_ema
add_files -fileset sim_ema ${TESTDIR}/sim_ema/tb_ema.sv
add_files -fileset sim_ema ${TESTDIR}/sim_ema/bd_ema/bd_ema.bd
make_wrapper -files [get_files *.bd] -top
add_files -fileset sim_ema ${TESTDIR}/sim_ema/bd_ema/hdl/bd_ema_wrapper.v
add_files -fileset sim_ema ${TESTDIR}/sim_ema/tb_ema_behav.wcfg
set_property top tb_ema [get_filesets sim_ema]

create_fileset -simset sim_ema2
add_files -fileset sim_ema2 ${TESTDIR}/sim_ema2/ema_tb.sv 
set_property top ema_tb [get_filesets sim_ema2]

# set *.sv to SystemVerilog
set_property file_type SystemVerilog [get_files *.sv]

#set the top for synthesis
set_property top design_fpga_wrapper [current_fileset]
# set active simulation
current_fileset -simset [ get_filesets sim_bitflip]

#make sims run longer by default
set_property -name {xsim.simulate.runtime} -value {1000us} -objects [get_filesets sim_*]

