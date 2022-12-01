
set MYFILE [file normalize [info script]]
set MYDIR  [file dirname ${MYFILE}]
set BASEDIR ${MYDIR}/../
set SRCDIR ${MYDIR}/../verilog/vsrc/
set TESTDIR ${MYDIR}/../verilog/vtests/ 

create_project -force vivado_project.xpr ${BASEDIR}/vivado_project -part xc7z020clg400-1

# add source files
add_files [glob ${SRCDIR}/*.v]
add_files [glob ${SRCDIR}/*.sv]

add_files ${SRCDIR}/bd_fadd/bd_fadd.bd
add_files ${SRCDIR}/bd_fmac/bd_fmac.bd
make_wrapper -files [get_files *.bd] -top
add_files ${SRCDIR}/bd_fadd/hdl/bd_fadd_wrapper.v
add_files ${SRCDIR}/bd_fmac/hdl/bd_fmac_wrapper.v

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

# set *.sv to SystemVerilog
set_property file_type SystemVerilog [get_files *.sv]

#set design top
set_property top axis_dot_20_10 [current_fileset]

# set active simulation
current_fileset -simset [ get_filesets sim_dot_20_10 ]

#make sims run longer by default
set_property -name {xsim.simulate.runtime} -value {1000us} -objects [get_filesets sim_*]

#launch_runs synth_1
#wait_on_run synth_1
