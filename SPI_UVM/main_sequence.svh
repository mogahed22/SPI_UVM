package main_sequence;
    import uvm_pkg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class main_sequence extends uvm_sequence #(spi_seq_item);
        `uvm_object_utils(main_sequence)
        spi_seq_item seq_item;
        function new(string name="main_sequence");
            super.new(name);
        endfunction
        task body;
            seq_item=spi_seq_item::type_id::create("seq_item");
            repeat(10000) begin
                start_item(seq_item);
                assert(seq_item.randomize());
                finish_item(seq_item);
            end
        endtask
    endclass
endpackage