/*========================================================
File name:      sequence_item.sv
Description:    APB base packet class
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/

class apb_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(apb_sequence_item);


    rand bit [7:0] a;
    rand bit [7:0] b;


//    constraint name1 { a == 0; };

//    constraint name2 { soft a == 0; };

    function new (string name = "apb_sequence_item");
        super.new(name);
    endfunction

    // pre-randomize and post-randomize functions

endclass: apb_sequence_item
