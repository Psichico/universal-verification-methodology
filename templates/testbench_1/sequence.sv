/*========================================================
File name:      sequence.sv
Description:    template
Author:         Jaimil Patel
Date created:   17 June 2020
=========================================================*/

class sequence_template extends uvm_sequence;
    `uvm_object_utils(sequence_template)

    //instantiate sequence_item 

    function new(string name= "sequence_template");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info(get_type_name(), " Sequence Started ", UVM_HIGH)
        //type id create your sequence_item here

        //repeat()
        //begin

        //end
    endtask: body

endclass: sequence_template

