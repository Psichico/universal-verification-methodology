/*========================================================
File name:      scoreboard.sv
Description:    APB scoreboard
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/


class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard)

    uvm_analysis_imp #(apb_sequence_item, apb_scoreboard) rx_port;
    
    apb_sequence_item base_pkt;

    function new(string name = "apb_scoreboard", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);

        base_pkt = apb_sequence_item::type_id::create("Base Packet");
        rx_port = new("Receive port",this);

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
    endfunction: connect_phase

    function void write(apb_sequence_item pkt);
    
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info(get_type_name(), " End of elaboration Phase ", UVM_HIGH);
    endfunction: end_of_elaboration_phase

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), " Start of Simulation Phase ", UVM_HIGH);
    endfunction: start_of_simulation_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), " Run Phase ", UVM_HIGH);
        

    endtask: run_phase

    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        `uvm_info(get_type_name(), " Extract Phase ", UVM_HIGH);
    endfunction: extract_phase

    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        `uvm_info(get_type_name(), " Check Phase ", UVM_HIGH);
    endfunction: check_phase

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), " Report Phase ", UVM_HIGH);
    endfunction: report_phase

    function void final_phase(uvm_phase phase);
        super.final_phase(phase);
        `uvm_info(get_type_name(), " Final Phase ", UVM_HIGH);
    endfunction: final_phase


endclass: apb_scoreboard
