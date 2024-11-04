package subscriber;
    import uvm_pkg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class spi_sbuscriber extends uvm_component;
        `uvm_component_utils(spi_sbuscriber)
        uvm_analysis_export #(spi_seq_item) sub_export;
        uvm_tlm_analysis_fifo #(spi_seq_item) sub_fifo;
        spi_seq_item sub_seq_item;

        ///cover groups here
        covergroup cg();
            MOSI_cp: coverpoint sub_seq_item.MOSI{
                bins read_address_sequence =(0,1=>1=>1=>0=>0,1[*9]);
                bins read_data_sequence=(0,1=>1[*3]=>0,1[*18]);
                bins write_address_sequence=(0,1=>0[*3]=>0,1[*9]);
                bins write_data_sequence=(0,1=>0=>0=>1=>0,1[*9]);
                bins mosilow = {0};
                bins mosihigh={1};
            }
            ss_n_cp: coverpoint sub_seq_item.SS_n{
                bins ss_trans1=(0[*12]=>1);
                bins ss_trans2=(0[*21]=>1);
                bins ss_n_low={0};
                bins ss_n_high={1};
            }
            MOSI_Operation: cross MOSI_cp,ss_n_cp{
                bins read_data_Sequenece= binsof(MOSI_cp.read_data_sequence) && binsof(ss_n_cp.ss_trans2) ;
				bins read_add_Sequenece= binsof(MOSI_cp.read_address_sequence) && binsof(ss_n_cp.ss_trans1) ;
				bins write_add_Sequenece= binsof(MOSI_cp.write_address_sequence) && binsof(ss_n_cp.ss_trans1) ;
				bins write_data_Sequenece= binsof(MOSI_cp.write_data_sequence) && binsof(ss_n_cp.ss_trans1) ;
				
            }
        endgroup

        function new(string name="spi_subscriber",uvm_component parent=null);
            super.new(name,parent);
            cg=new();
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            sub_export=new("sub_export",this);
            sub_fifo=new("sub_fifo",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            sub_export.connect(sub_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sub_fifo.get(sub_seq_item);
                if(sub_seq_item.rst_n)
                    cg.sample();
            end
        endtask
    endclass
endpackage