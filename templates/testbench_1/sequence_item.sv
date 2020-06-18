/*========================================================
File name:      sequence_item.sv
Description:    template
Author:         Jaimil Patel
Date created:   17 June 2020
=========================================================*/

class sequence_item_template extends uvm_sequence_item;
    `uvm_object_utils(sequence_item_template);


    rand bit [7:0] a;
    rand bit [7:0] b;


//    constraint name1 { a == 0; };

//    constraint name2 { soft a == 0; };

    function new (string name = "sequence_item_template");
        super.new(name);
    endfunction

    // pre-randomize and post-randomize functions

endclass: sequence_item_template
