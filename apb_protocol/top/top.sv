/*========================================================
File name:      top.sv
Description:    APB protocol top module
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/


`include "uvm_macros.svh"
import uvm_pkg::*;

`include "./top/interface.sv"
`include "./env/packet/sequence_item.sv"
`include "./test/sequence/sequence.sv"
`include "./env/agent/sequencer.sv"
`include "./env/agent/driver.sv"
`include "./env/agent/monitor.sv"
`include "./env/agent/agent.sv"
`include "./env/scoreboard/scoreboard.sv"
`include "./env/env.sv"
`include "./test/test.sv"

//include DUT here

module top();

    reg clock;

    apb_interface intf(.clock(clock));

    //instantiate your DUT here and connect it with interface using dot method


    initial begin
        uvm_config_db #(virtual apb_interface)::set(null, "*", "intf", intf);
    end
    

    initial begin
        run_test();
    end

    initial begin
        clock = 0;
        #50;
        forever begin
        #2 clock = 0;
        #2 clock = 1;
        end
    end

/*
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end
*/


endmodule: top
