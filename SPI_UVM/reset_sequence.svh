package reset_sequence;
import uvm_pkg::*;
import sequence_item::*;
`include "uvm_macros.svh"
class reset_sequence extends uvm_sequence #(spi_seq_item);
    `uvm_object_utils(reset_sequence)
    spi_seq_item seq_item;
    function new(string name="reset_sequence");
        super.new(name);
    endfunction
    task body;
        seq_item=spi_seq_item::type_id::create("seq_item");
        repeat(5)begin
            start_item(seq_item);
            seq_item.rst_n=0;
            seq_item.MOSI=$random;
            seq_item.SS_n=$random;
            finish_item(seq_item);
        end
    endtask
endclass
endpackage