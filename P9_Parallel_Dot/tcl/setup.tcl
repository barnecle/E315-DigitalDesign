
set MYFILE [file normalize [info script]]
set MYDIR  [file dirname ${MYFILE}]
set BASEDIR ${MYDIR}/../
set SRCDIR ${MYDIR}/../verilog/vsrc/
set TESTDIR ${MYDIR}/../verilog/vtests/ 

create_project -force vivado_project.xpr ${BASEDIR}/vivado_project -part xc7z020clg400-1

# add source files
add_files ${SRCDIR}/axis_dot_80_40.v
add_files ${SRCDIR}/axis_dot_40_20.v
add_files ${SRCDIR}/axis_dot_20_10.v
add_files ${SRCDIR}/accel_dot.sv
add_files ${SRCDIR}/dot.sv
add_files ${SRCDIR}/dot_20_10.sv
add_files ${SRCDIR}/dot_40_20.sv
add_files ${SRCDIR}/dot_80_40.sv
add_files ${SRCDIR}/axis_fmac.sv
add_files ${SRCDIR}/axis_fadd.sv

add_files ${SRCDIR}/bd_fadd/bd_fadd.bd
add_files ${SRCDIR}/bd_fmac/bd_fmac.bd
add_files ${SRCDIR}/bd_fpga/bd_fpga.bd

make_wrapper -files [get_files *.bd] -top
add_files ${SRCDIR}/bd_fadd/hdl/bd_fadd_wrapper.v
add_files ${SRCDIR}/bd_fmac/hdl/bd_fmac_wrapper.v
add_files ${SRCDIR}/bd_fpga/hdl/bd_fpga_wrapper.v

#set top
set_property top bd_fpga_wrapper [current_fileset]

# add testbenches
create_fileset -simset sim_dot
add_files -fileset sim_dot ${TESTDIR}/dot/dot_tb.sv
set_property top dot_tb [get_filesets sim_dot]

create_fileset -simset sim_accel_dot
add_files -fileset sim_accel_dot ${TESTDIR}/accel_dot/accel_dot_tb.sv
set_property top accel_dot_tb [get_filesets sim_accel_dot]

create_fileset -simset sim_dot_20_10
add_files -fileset sim_dot_20_10 ${TESTDIR}/dot_20_10/dot_20_10_tb.sv
set_property top dot_20_10_tb [get_filesets sim_dot_20_10]

create_fileset -simset sim_dot_40_20
add_files -fileset sim_dot_40_20 ${TESTDIR}/dot_40_20/dot_40_20_tb.sv
set_property top dot_40_20_tb [get_filesets sim_dot_40_20]

create_fileset -simset sim_dot_80_40
add_files -fileset sim_dot_80_40 ${TESTDIR}/dot_80_40/dot_80_40_tb.sv
set_property top dot_80_40_tb [get_filesets sim_dot_80_40]

# set *.sv to SystemVerilog
set_property file_type SystemVerilog [get_files *.sv]

# set active simulation
current_fileset -simset [ get_filesets sim_accel_dot ]

#make sims run longer by default
set_property -name {xsim.simulate.runtime} -value {1000us} -objects [get_filesets sim_*]

#seems to help surpress warning messages
update_compile_order -fileset sources_1
update_module_reference bd_fpga_axis_dot_20_10_0_0
update_module_reference bd_fpga_axis_dot_40_20_0_0

#https://support.xilinx.com/s/question/0D52E00006hpZuYSAU/error-synth-84556-size-of-variable-is-too-large-to-handle-?language=en_US
set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 5000000"

#launch_runs synth_1
#wait_on_run synth_1
