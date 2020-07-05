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


module top();

    reg clock;
    reg pready;
    reg preset;
    reg pslverr;

    apb_interface intf(.pclk(clock),.pready(pready), .preset(preset), .pslverr(pslverr));

    initial begin
        uvm_config_db #(virtual apb_interface)::set(null, "*", "intf", intf);
    end
    
    // Run your test
    initial begin
        run_test();
    end

    // Reset everything
    initial begin
        preset = 0;
        #50;
        preset = 1;
    end

    // PREADY signal toggling which generally happpens on slave side
    initial begin
        pready  = 0;
        #45;
        forever begin 
            #1;
            // Randomly assigning values to HIT and MISS the posedge clock
            repeat($urandom_range(2, 10)) begin
                pready = 0;
            end
            repeat($urandom_range(0, 5)) begin
                pready = 1;
            end
        end
    end

    // Generating PSLVERR signal from slave to indicate signal failure
    initial begin
        pslverr = 0;
        #500;
        pslverr = 1;
        #200;
        pslverr = 0;

    end

    // Generating clock
    initial begin
        clock  = 0;
        #50;
        forever begin
        #2; 
        clock = 0;
        #2; 
        clock = 1;
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end

endmodule: top
