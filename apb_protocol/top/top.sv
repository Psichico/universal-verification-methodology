/*========================================================
File name:      top.sv
Description:    APB protocol top module
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/


`include "./top/defines.sv"
`include "./top/interface.sv"
`include "./apb_package.sv"
`include "uvm_macros.svh"
import apb_pkg::*;
import uvm_pkg::*;


//include DUT here

module top();

    reg clock;
    reg pready;

    apb_interface intf(.pclk(clock),.pready(pready));

    //instantiate your DUT here and connect it with interface using dot method


    initial begin
        uvm_config_db #(virtual apb_interface)::set(null, "*", "intf", intf);
    end
    

    initial begin
        run_test();
        //#50;
        //pready =0;
        #20;
        pready =1;
    end

    initial begin
        clock  = 0;
        //pready = 1;
        #50;
        forever begin
        #2 clock = 0;
        #2 clock = 1;
           //pready = ~pready;
        end
    end


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end



endmodule: top
