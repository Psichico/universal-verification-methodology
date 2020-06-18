/*========================================================
File name:      agent.sv
Description:    template
Author:         Jaimil Patel
Date created:   17 June 2020
=========================================================*/


class agent_template extends uvm_agent;
    `uvm_component_utils(agent_template)

    //instantiate driver, sequencer, monitor
    driver_template     drv;
    sequencer_template  seqr;
    monitor_template    mon;
    
    function new(string name = "agent_template", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
        // type_id create subcomponents here
        drv  = driver_template::type_id::create("Driver",this);
        seqr = sequencer_template::type_id::create("Sequencer",this);
        mon  = monitor_template::type_id::create("Monitor",this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
        // connect subcomponents here
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction: connect_phase

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
        
        //phase.raise_objection(this);
        
            //implement logic here
        
        //phase.drop_objection(this);

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


endclass: agent_template
