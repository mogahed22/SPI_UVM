module top;

import uvm_pkg::*;
import test::*;
`include "uvm_macros.svh"
logic clk;

////inistantiate dut and interface here
WRAPPER_interface inf(clk);
WRAPPER_golden_Model WRAPPER_gold_inst(inf);
Wrapper Wrapper_inst (inf);
initial begin
    forever begin
        #1 clk=~clk;
    end
end

initial begin
    uvm_config_db#(virtual WRAPPER_interface)::set(null,"uvm_test_top","spi_inf",inf);
    run_test("spi_test");
end

endmodule