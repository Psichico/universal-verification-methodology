APB_Protocol

SCRIPT FILES:
  delete
  open_files
  run
  swp_delete
  
TESTBENCH FILES:
  apb_package.sv
  top
  test
  env
  
IHI0024C_amba_apb_protocol_spec: APB Specification
 
Features of this testbench:
  This testbench includes the detection of PSLVERR signal to detect signal failure on slave side.
  PADDR and PDATA are randomized.
  Monitors only samples the interface when slave is ready.
  Driver keeps on driving irrespective of slave state.
  
FUTURE IMPROVEMENT: 
  Adding a slave.
  Scoreboard logic implementation.
