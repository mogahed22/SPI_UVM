package test;
    import uvm_pkg::*;
    import environment::*;
    import config_obj::*;
    import sequence_item::*;
    import reset_sequence::*;
    import main_sequence::*;
    `include "uvm_macros.svh"
    class spi_test extends uvm_test;
        `uvm_component_utils(spi_test)
        spi_env env;
        spi_config_obj cobj;
        virtual spi_inf vinf;
        reset_sequence rst_seq;
        main_sequence main_seq;
        function new(string name="spi_test",uvm_component parent=null);
            super.new(name,parent);
        endfunction
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            env=spi_env::type_id::create("env",this);
            cobj=spi_config_obj::type_id::create("cobj",this);
            main_seq=main_sequence::type_id::create("main_seq");
            rst_seq=reset_sequence::type_id::create("rst_seq");
            if(!uvm_config_db#(virtual WRAPPER_interface)::get(this,"","spi_inf",cobj.vinf))
                `uvm_fatal("build_phase","test-unabel to get the virtual interface of spi form the uvm_config_db");
            uvm_config_db#(spi_config_obj)::set(this,"*","spi_config_obj",cobj);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);
            rst_seq.start(env.agent.spi_sequencer_I);
            main_seq.start(env.agent.spi_sequencer_I);
            phase.drop_objection(this);
        endtask
    endclass
endpackage