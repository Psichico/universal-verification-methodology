/*========================================================
File name:      monitor.sv
Description:    APB monitor
Author:         Jaimil Patel
Date created:   17 June 2020
=========================================================*/


class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor)

    //create monitor port
    uvm_analysis_port #(apb_sequence_item) tx_port;

    //instantiate virtual interface, config_class, sequence_item
    apb_sequence_item base_pkt;
    virtual apb_interface intf;

    function new(string name = "monitor_template", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
        // type_id create subcomponents here
        tx_port = new("Monitor output",this);
        base_pkt     = apb_sequence_item::type_id::create("Base Packet");
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
        @(posedge intf.pclk);
            
            if(intf.pready == 0)
            begin
                sample_new_values();
            end
            else
            begin
                keep_old_values();
            end
            
            `uvm_info(get_type_name(),$sformatf("%d %d %d %d ", base_pkt.pdata, base_pkt.penable, base_pkt.psel, base_pkt.paddr), UVM_LOW)
            tx_port.write(base_pkt);
            

        end
        
    endtask: run_phase

    task sample_new_values(); //add virtual here
            case(intf.pwrite)
                READ:
                begin
                    base_pkt.pdata <= intf.prdata; 
                end
                WRITE:
                begin
                    base_pkt.pdata <= intf.pwdata;
                end
            endcase
        base_pkt.preset     <= intf.preset;
        base_pkt.pprot      <= intf.pprot;
        base_pkt.penable    <= intf.penable;
        //base_pkt.pwrite     <= intf.pwrite;
        base_pkt.pready     <= intf.pready;
        base_pkt.pslverr    <= intf.pslverr;
        base_pkt.paddr      <= intf.paddr;
        base_pkt.psel       <= intf.psel;
        //base_pkt.pwdata     <= intf.pwdata;
        base_pkt.pstrb      <= intf.pstrb;
        //base_pkt.prdata     <= intf.prdata;
    endtask: sample_new_values

    task keep_old_values(); //add virtual here
        base_pkt.pdata      <= base_pkt.pdata; 
        base_pkt.preset     <= base_pkt.preset;
        base_pkt.pprot      <= base_pkt.pprot;
        base_pkt.penable    <= base_pkt.penable;
        //base_pkt.pwrite     <= base_pkt.pwrite;
        base_pkt.pready     <= base_pkt.pready;
        base_pkt.pslverr    <= base_pkt.pslverr;
        base_pkt.paddr      <= base_pkt.paddr;
        base_pkt.psel       <= base_pkt.psel;
        //base_pkt.pwdata     <= base_pkt.pwdata;
        base_pkt.pstrb      <= base_pkt.pstrb;
        //base_pkt.prdata     <= base_pkt.prdata;
    endtask: keep_old_values

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
