	alias clc ".main clear"

	clc
	exec vlib work
	vmap work work

	set TB					"./sim/tb/tb.v"
	set hdl_path			"./src/hdl"
	set inc_path			"./src/inc"

	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here
#	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/verilog_file_name.v
#	vlog 	+acc -incr -source  +define+SIM 	$inc_path/implementation_option.vh

	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/col_parity.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/controller.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/counter.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/datapath.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/encoder.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/memory.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/MUX3Dto1.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/register.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/revaluate.v
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./$hdl_path/rotate.v

	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	$TB
#	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB work.TB


#======================= adding signals to wave window ==========================

	add wave -hex -group 	 	{TB}				sim:/*
#	add wave -hex -group 	 	{top}				sim:/$TB/uut/*
#	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================

	configure wave -signalnamewidth 2

#====================================== run =====================================

	run $run_time
