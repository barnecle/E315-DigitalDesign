
if { $argc != 2 } {
    puts [ concat "Usage: " $argv0  "BasePath MaxCores" ]
    puts "Please try again"
} else {
    set BASE_PATH [ lindex $argv 0 ]
    set NUM_CORES [ lindex $argv 1 ]
    puts [ concat "BASE_PATH: " $BASE_PATH]
    puts [ concat "NUM_CORES: " $NUM_CORES]

    open_project ${BASE_PATH}/vivado_project/vivado_project.xpr
    launch_runs impl_1 -to_step write_bitstream -jobs ${NUM_CORES}
    wait_on_run impl_1 
}



