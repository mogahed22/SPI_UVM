package environment;
    import uvm_pkg::*;
    import agent::*;
    import scoreboard::*;
    import subscriber::*;
    `include "uvm_macros.svh"
    class spi_env extends uvm_env;
        `uvm_component_utils(spi_env)
        spi_agent agent;
        spi_sbuscriber sub;
        spi_scoreboard scb;
        function new(string name="spi_env",uvm_component parent=null);
            super.new(name,parent);
        endfunction
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            agent=spi_agent::type_id::create("agent",this);
            sub=spi_sbuscriber::type_id::create("sub",this);
            scb=spi_scoreboard::type_id::create("scb",this);
        endfunction
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            agent.agent_ap.connect(scb.sb_export);
            agent.agent_ap.connect(sub.sub_export);
        endfunction
    endclass
endpackage