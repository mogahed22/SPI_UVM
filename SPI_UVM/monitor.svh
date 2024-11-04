package monitor;
    import uvm_pkg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class spi_monitor extends uvm_monitor;
        `uvm_component_utils(spi_monitor)
        virtual WRAPPER_interface vinf;
        spi_seq_item rsp_seq_item;
        uvm_analysis_port #(spi_seq_item) mon_ap;
        function new(string name="spi_monitor",uvm_component parent=null);
            super.new(name,parent);
        endfunction
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            mon_ap = new("mon_ap",this);
        endfunction:build_phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);

            forever begin
                rsp_seq_item=spi_seq_item::type_id::create("rsp_seq_item");
                rsp_seq_item.rst_n=vinf.rst_n;
                rsp_seq_item.MOSI=vinf.MOSI;
                rsp_seq_item.SS_n=vinf.SS_n;
                rsp_seq_item.MISO=vinf.MISO;
                rsp_seq_item.MISO_expected=vinf.MISO_expected;
                mon_ap.write(rsp_seq_item);
                `uvm_info("run_phase",rsp_seq_item.convert2string(),UVM_HIGH)
            end
        endtask
        
    endclass
endpackage