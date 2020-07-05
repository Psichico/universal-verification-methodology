/*========================================================
File name:      sequence_item.sv
Description:    APB base packet class
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/

class apb_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(apb_sequence_item);

    
    rand transaction_type pwrite;
    rand bit [`APB_REG_ADDR_HIGH : `APB_REG_ADDR_LOW]        paddr;
    rand bit [`APB_REG_DATA_HIGH : `APB_REG_DATA_LOW]        pdata;

    //rand bit [`APB_REG_STROBE_HIGH : `APB_REG_STROBE_LOW]    pstrb;
    //rand bit pprot;  // data access or instruction access

    function new (string name = "apb_sequence_item");
        super.new(name);
    endfunction

    // pre-randomize and post-randomize functions

endclass: apb_sequence_item
