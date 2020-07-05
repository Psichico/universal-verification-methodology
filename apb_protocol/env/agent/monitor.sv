/*========================================================
File name:      monitor.sv
Description:    APB monitor
Author:         Jaimil Patel
Date created:   17 June 2020
=========================================================*/


class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor)

    uvm_analysis_port #(apb_sequence_item) tx_port;

    apb_sequence_item base_pkt;
    virtual apb_interface intf;

    function new(string name = "monitor_template", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);

        tx_port = new("Monitor output",this);
        base_pkt     = apb_sequence_item::type_id::create("Base Packet");
        if (! (uvm_config_db #(virtual apb_interface)::get(this,"*","intf", intf)))
            `uvm_error(get_type_name(), "Could not get interface");

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
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
        
        forever begin
        @(posedge intf.pclk);
            
            if(intf.pready == 1)
            begin
                sample_new_values(); //slave will only take the new values when PREADY is high
                if( (intf.pready & intf.psel & intf.penable & intf.pslverr) == 0) 
                begin
                    tx_port.write(base_pkt);
                    `uvm_info(get_type_name(),$sformatf("WRITING: pslverr= %d ", intf.pslverr), UVM_LOW)
                end
                else 
                begin
                    `uvm_info(get_type_name(),$sformatf("SLAVE DIDN'T RECEIVE THE TRANSACTION PROPERLY: pslverr= %d ", intf.pslverr), UVM_LOW)
                end
            end
        end
        
    endtask: run_phase

    task sample_new_values(); //add virtual here    
        `uvm_info(get_type_name(), "MONITORING", UVM_LOW)
        base_pkt.pdata      <= intf.pwrite ? intf.pwdata : intf.prdata;
        //base_pkt.pwrite     <= intf.pwrite; // This wil give error which can be fixed by static casting
        base_pkt.pwrite = transaction_type'(intf.pwrite); //Static cast. The above line will give error.
        base_pkt.paddr      <= intf.paddr;

        //base_pkt.pstrb      <= intf.pstrb;
        //base_pkt.pprot      <= intf.pprot;
    endtask: sample_new_values

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


endclass: apb_monitor
