/*========================================================
File name:      driver.sv
Description:    APB driver
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/


class apb_driver extends uvm_driver #(apb_sequence_item);
    `uvm_component_utils(apb_driver)

    apb_sequence_item base_pkt;
    virtual apb_interface intf;

    function new(string name = "apb_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), " Build Phase ", UVM_HIGH);
        
        base_pkt = apb_sequence_item::type_id::create("Base Packet");
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
        @(posedge intf.pclk) //try putting this inside drive task

            //base_pkt.print(); //remove comment if you want to print packets
            if(intf.preset == 0)
            begin
                apb_reset();
            end
        
            else
            begin
                seq_item_port.get_next_item(base_pkt);
                apb_drive();
                //seq_item_port.item_done(base_pkt); //this means you are sending a response
                seq_item_port.item_done(); //you are not sending a response

            end
        end
    endtask: run_phase

    task apb_reset();
        `uvm_info(get_type_name(), "RESETING" , UVM_LOW)
        intf.penable    <= 0;
        intf.paddr      <= 0;
        intf.psel       <= 0;
        intf.pwdata     <= 0;
        //intf.pstrb      <= base_pkt.pstrb;
        //intf.pprot      <= base_pkt.pprot;
    endtask: apb_reset

    task apb_drive(); //add virtual here
        `uvm_info(get_type_name(), "DRIVING" , UVM_LOW)
        intf.psel       <= 1;
        intf.penable    <= 0;
        intf.pwrite     <= base_pkt.pwrite;
        intf.paddr      <= base_pkt.paddr;
        intf.pwdata     <= base_pkt.pwrite ? base_pkt.pdata : 0;
        @(posedge intf.pclk) //access phase should happen in next clock cycle as setup cycle
            intf.penable    <= 1;
            wait(intf.pready == 1); //if slave is driving PREADY low then wait.
            @(posedge intf.pclk)
                intf.penable <= 0;
                intf.psel    <= 0;
            
        //intf.pstrb      <= base_pkt.pstrb;
        //intf.pprot      <= base_pkt.pprot;
    endtask: apb_drive

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
