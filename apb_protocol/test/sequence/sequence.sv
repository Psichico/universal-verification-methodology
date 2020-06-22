/*========================================================
File name:      sequence.sv
Description:    APB Base sequence and other sequences
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/

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

