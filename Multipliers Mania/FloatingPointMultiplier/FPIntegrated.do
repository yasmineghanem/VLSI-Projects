vlog FLoatingPointMultiplier.v
vlog ../Register.v
vlog FPIntegrated.v

vsim FPIntegratedTB

add wave *
run -all