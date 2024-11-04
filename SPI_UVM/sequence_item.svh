package sequence_item;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    class spi_seq_item extends uvm_sequence_item;
        `uvm_object_utils(spi_seq_item)
        ////define the fields of your sequence item

        rand logic SS_n, rst_n;
		randc logic MOSI;
		logic MISO,MISO_expected;

        function new(string name ="spi_seq_item");
            super.new(name);
        endfunction

        function string convert2string();
			return $sformatf(" %s  reset=%0b , MOSI=%0b , SS_n=%0b, MISO=%0b MISO_expected=%0b"
			,super.convert2string(), rst_n, MOSI, SS_n, MISO, MISO_expected,);
		endfunction: convert2string

		function string convert2string_stimulus();
			return $sformatf("reset=%0b , MOSI=%0b , SS_n=%0b",rst_n, MOSI, SS_n);
		endfunction: convert2string_stimulus
        ////add constraint blocks here

        constraint reset {
			rst_n dist {0:=1 , 1:=99};
		}
    endclass
endpackage