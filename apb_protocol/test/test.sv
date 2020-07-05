/*========================================================
File name:      test.sv
Description:    APB test
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/


class apb_test extends uvm_test;
    `uvm_component_utils(apb_test)

    apb_env     env;
    apb_random  rnd;

    function new(string name = "apb_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
        env = apb_env::type_id::create("env",this);

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
    endfunction: connect_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info(get_type_name(), " End of elaboration Phase ", UVM_HIGH);
        uvm_top.print_topology();

    endfunction: end_of_elaboration_phase

    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        `uvm_info(get_type_name(), " Start of Simulation Phase ", UVM_HIGH);
    endfunction: start_of_simulation_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), " Run Phase ", UVM_HIGH);
        
        phase.raise_objection(this);
        
        rnd = apb_random::type_id::create("rnd",this);
        rnd.start(env.agnt.seqr);
        #10; //should wait for some time in order to let the driver-monitor mechanism process the last sequence.

        phase.drop_objection(this);

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


endclass: apb_test
