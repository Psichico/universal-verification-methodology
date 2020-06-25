/*========================================================
File name:      sequence.sv
Description:    APB Base sequence and other sequences
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/


// BASE SEQUENCE
class apb_sequence extends uvm_sequence;
    `uvm_object_utils(apb_sequence)

    //instantiate sequence_item 
    apb_sequence_item base_pkt;

    function new(string name= "apb_sequence");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), " Base Sequence Started ", UVM_HIGH)
    endtask: body

endclass: apb_sequence


// RESET SEQUENCE
class apb_reset extends apb_sequence;
    `uvm_object_utils(apb_reset)

    apb_sequence_item reset_pkt;

    function new(string name= "apb_reset");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), " Reset Sequence Started ", UVM_LOW)
        reset_pkt = apb_sequence_item::type_id::create(" Reset Packet ");
        repeat (1)
        begin
            start_item(reset_pkt);
            reset_pkt.randomize() with {reset_pkt.preset == 0; reset_pkt.penable == 0; reset_pkt.psel == 0;};
            finish_item(reset_pkt);
        end
    endtask: body

endclass: apb_reset



// SETUP SEQUENCE
class apb_setup extends apb_sequence;
    `uvm_object_utils(apb_setup)

    apb_sequence_item setup_pkt;

    function new(string name= "apb_setup");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), " Setup Sequence Started ", UVM_LOW)
        setup_pkt = apb_sequence_item::type_id::create(" Setup Packet ");
        repeat (1)
        begin
            start_item(setup_pkt);
            setup_pkt.randomize() with {setup_pkt.preset == 1; setup_pkt.penable == 0; setup_pkt.psel == 1; };
            finish_item(setup_pkt);
        end
    endtask: body

endclass: apb_setup



// ACCESS SEQUENCE
class apb_access extends apb_sequence;
    `uvm_object_utils(apb_access)

    apb_sequence_item access_pkt;

    function new(string name= "apb_access");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), " Access Sequence Started ", UVM_LOW)
        access_pkt = apb_sequence_item::type_id::create(" Access Packet ");
        repeat (1)
        begin
            start_item(access_pkt);
            access_pkt.randomize() with {access_pkt.preset == 1; access_pkt.penable == 1; access_pkt.psel == 1; };
            finish_item(access_pkt);
        end
    endtask: body

endclass: apb_access




