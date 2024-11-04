package agent;
    import uvm_pkg::*;
    import config_obj::*;
    import sequence_item::*;
    import sequencer::*;
    import driver::*;
    import monitor::*;
    `include "uvm_macros.svh"
    class spi_agent extends uvm_agent;
        `uvm_component_utils(spi_agent)
        spi_config_obj spi_config_obj_I;
        spi_seq_item spi_seq_item_I;
        spi_sequencer spi_sequencer_I;
        spi_monitor spi_monitor_I;
        spi_driver spi_driver_I;
        uvm_analysis_port #(spi_seq_item) agent_ap;
        function new(string name="spi_agent",uvm_component parent=null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            spi_config_obj_I=spi_config_obj::type_id::create("spi_config_obj_I");
            if(!uvm_config_db #(spi_config_obj)::get(this,"","spi_config_obj",spi_config_obj_I))
                `uvm_fatal("build_phase","unable to get configuration")
            spi_driver_I=spi_driver::type_id::create("spi_driver_I",this);
            spi_sequencer_I=spi_sequencer::type_id::create("spi_sequencer_I",this);
            spi_monitor_I=spi_monitor::type_id::create("spi_monitor_I",this);
            agent_ap=new("agent_ap",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            spi_driver_I.vinf=spi_config_obj_I.vinf;
            spi_driver_I.seq_item_port.connect(spi_sequencer_I.seq_item_export);
            spi_monitor_I.vinf=spi_config_obj_I.vinf;
            spi_monitor_I.mon_ap.connect(agent_ap);
        endfunction
    endclass
endpackage