package scoreboard;
    import uvm_pkg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class spi_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(spi_scoreboard)
        uvm_analysis_export #(spi_seq_item) sb_export;
        uvm_tlm_analysis_fifo #(spi_seq_item) sb_fifo;
        spi_seq_item sb_seq_item;
        int error_count=0;
        int correct_count=0;
        function new(string name="spi_scoreboard",uvm_component parent =null);
            super.new(name,parent);
        endfunction
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            sb_export=new("sb_export",this);
            sb_fifo=new("sb_fifo",this);
        endfunction
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            sb_export.connect(sb_fifo.analysis_export);
        endfunction
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sb_fifo.get(sb_seq_item);
               if(sb_seq_item.MISO !== sb_seq_item.MISO_expected ) begin
                    error_count++;
                    `uvm_error("sb_run_phase",$sformatf("error happened with dout signal input values are %s dout is %0h and the golden model output is %0h", sb_seq_item.convert2string_stimulus(),sb_seq_item.MISO ,sb_seq_item.MISO_expected))
               end
               else begin
                correct_count++;
               end
            end
        endtask
        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("total successful transactions:%0d",correct_count),UVM_MEDIUM);
            `uvm_info("report_phase",$sformatf("total failed transaction:%0d",error_count),UVM_MEDIUM)
        endfunction
    endclass
endpackage