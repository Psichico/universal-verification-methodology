/*========================================================
File name:      top.sv
Description:    APB protocol package
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/

//`include "uvm_macros.svh"

package apb_pkg;

    import uvm_pkg::*;
    typedef enum bit {READ, WRITE} transaction_type;
    `include "./env/packet/sequence_item.sv"
    `include "./test/sequence/sequence.sv"
    `include "./env/agent/sequencer.sv"
    `include "./env/agent/driver.sv"
    `include "./env/agent/monitor.sv"
    `include "./env/agent/agent.sv"
    `include "./env/scoreboard/scoreboard.sv"
    `include "./env/env.sv"
    `include "./test/test.sv"

endpackage: apb_pkg
