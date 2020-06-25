/*========================================================
File name:      sequence_item.sv
Description:    APB base packet class
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/

class apb_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(apb_sequence_item);

    //transaction_type tx_type;

    rand bit preset; //active low
    rand bit pprot;  // data access or instruction access
    rand bit penable;
    rand transaction_type pwrite;
         bit pready;
         bit pslverr;
    
    rand bit [`APB_REG_ADDR_HIGH : `APB_REG_ADDR_LOW]        paddr;
    rand bit [`TOTAL_NUMBER_OF_SLAVES - 1 : 0]               psel;
    rand bit [`APB_REG_DATA_HIGH : `APB_REG_DATA_LOW]        pdata;
    rand bit [`APB_REG_STROBE_HIGH : `APB_REG_STROBE_LOW]    pstrb;
   //      bit [`APB_REG_DATA_HIGH : `APB_REG_DATA_LOW]        prdata;

    constraint apb_reset_1 { soft preset == 1; };
    //constraint apb_reset_2 { preset == 0 -> penable == 0 && psel == 0;};

    function new (string name = "apb_sequence_item");
        super.new(name);
    endfunction

    // pre-randomize and post-randomize functions

endclass: apb_sequence_item
