/*========================================================
File name:      interface.sv
Description:    APB interface
Author:         Jaimil Patel
Date created:   21 June 2020
=========================================================*/

interface apb_interface (input logic pclk);

    bit preset; //active low
    bit pprot;
    bit penable;
    bit pwrite;
    bit pready;
    bit pslverr;
    
    bit [`APB_REG_ADDR_HIGH : `APB_REG_ADDR_LOW]        paddr;
    bit [`TOTAL_NUMBER_OF_SLAVES - 1 : 0]               psel;
    bit [`APB_REG_DATA_HIGH : `APB_REG_DATA_LOW]        pwdata;
    bit [`APB_REG_STROBE_HIGH : `APB_REG_STROBE_LOW]    pstrb;
    bit [`APB_REG_DATA_HIGH : `APB_REG_DATA_LOW]        prdata;

endinterface: apb_interface
