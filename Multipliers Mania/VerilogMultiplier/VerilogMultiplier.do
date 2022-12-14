vlog VerilogMultiplier.v
vlog VerilogMultiplierTB.v
vlog VerilogMultiplierIntegrated.v
vlog VerilogMultiplierIntegratedTB.v
#vlog ../Register.v

vsim VerilogMultiplierIntegratedTB

add wave *
run -all