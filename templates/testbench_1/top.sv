/*========================================================
File name:      top.sv
Description:    template
Author:         Jaimil Patel
Date created:   17 June 2020
=========================================================*/


`include "uvm_macros.svh"
import uvm_pkg::*;

`include "./sequence_item.sv"
`include "./sequence.sv"
`include "./sequencer.sv"
`include "./driver.sv"
`include "./monitor.sv"
`include "./agent.sv"
`include "./scoreboard.sv"
`include "./env.sv"
`include "./test.sv"

//include DUT here



module top();

    //instantiate your interface here.

    //instantiate your DUT here and connect it with interface using dot method


    //set your virtual interface here
    /*
    initial begin
        uvm_config_db #(virtual intf_name)::set(null, "*", "intf", intf)
    end
    */

    initial begin
        run_test();
    end



/*
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end
*/


endmodule: top
