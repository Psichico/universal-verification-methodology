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



// Random SEQUENCE
class apb_random extends apb_sequence;
    `uvm_object_utils(apb_random)

    apb_sequence_item random_pkt;

    function new(string name= "apb_random");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), " Random Sequence Started ", UVM_LOW)
        random_pkt = apb_sequence_item::type_id::create(" Random Packet ");
        repeat (1000)
        begin
            start_item(random_pkt);
            random_pkt.randomize();
            finish_item(random_pkt);
        end
    endtask: body

endclass: apb_random

