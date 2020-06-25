/*========================================================
File name:      driver.sv
Description:    APB driver
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/


class apb_driver extends uvm_driver #(apb_sequence_item);
    `uvm_component_utils(apb_driver)

    //instantiate sequence_items, virtual interface, config_database
    apb_sequence_item base_pkt;
    virtual apb_interface intf;

    function new(string name = "apb_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
        // type_id create subcomponents here
        base_pkt = apb_sequence_item::type_id::create("Base Packet");
        if (! (uvm_config_db #(virtual apb_interface)::get(this,"*","intf", intf)))
            `uvm_error(get_type_name(), "Could not get interface");
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), " Connect Phase ", UVM_HIGH);
        // connect subcomponents here
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
        @(posedge intf.pclk) //try putting this inside drive task
            seq_item_port.get_next_item(base_pkt);
            //base_pkt.print();
            //`uvm_info(get_type_name(),$sformatf("HERE: %d", base_pkt.psel), UVM_LOW)
            if(intf.pready) //only drive new values if PREADY signal is high.
            begin
                drive();
            end
            seq_item_port.item_done(base_pkt);
        end
        
        

    endtask: run_phase

    task drive(); //add virtual here
        
        `uvm_info(get_type_name(), "DRIVING" , UVM_LOW)
        intf.preset     <= base_pkt.preset;
        intf.pprot      <= base_pkt.pprot;
        intf.penable    <= base_pkt.penable;
        intf.pwrite     <= base_pkt.pwrite;
        //intf.pready     <= base_pkt.pready; //slave's signal
        //intf.pslverr    <= base_pkt.pslverr; //slave's signal
        intf.paddr      <= base_pkt.paddr;
        intf.psel       <= base_pkt.psel;
        intf.pwdata     <= base_pkt.pdata;
        intf.pstrb      <= base_pkt.pstrb;
        //intf.prdata     <= base_pkt.prdata; //slave's signal

    endtask: drive

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


endclass: apb_driver
