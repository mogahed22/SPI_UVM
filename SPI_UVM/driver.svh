package driver;

    import uvm_pkg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"

    class spi_driver extends uvm_driver #(spi_seq_item);
        `uvm_component_utils(spi_driver)

        virtual WRAPPER_interface vinf;
        spi_seq_item stim_seq_item;

        function new(string name="spi_driver",uvm_component parent=null);
            super.new(name,parent);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);

            forever begin
                stim_seq_item=spi_seq_item::type_id::create("stim_seq_item");
                seq_item_port.get_next_item(stim_seq_item);
                vinf.rst_n=stim_seq_item.rst_n;
                vinf.MOSI=stim_seq_item.MOSI;
                vinf.SS_n=stim_seq_item.SS_n;
                @(negedge vinf.clk);
                seq_item_port.item_done();
                `uvm_info("run_phase",stim_seq_item.convert2string_stimulus(),UVM_HIGH)
            end
            
        endtask

    endclass
endpackage