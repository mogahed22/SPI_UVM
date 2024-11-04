vlib work
vlog -f compile.txt +cover -covercells
vsim -voptargs=+acc work.top -cover -classdebug -uvmcontrol=all 
add wave /top/inf/*
#add wave /top/Wrapper_inst/wrap_sva_insta/Asynchronous_reset /Top_WRAPPER/WRAPPER_insta/wrap_sva_insta/MOSI_read_ap /Top_WRAPPER/WRAPPER_insta/wrap_sva_insta/MOSI_Write_ap /Top_WRAPPER/WRAPPER_insta/wrap_sva_insta/SS_correct_sequence_Readadd_ap /Top_WRAPPER/WRAPPER_insta/wrap_sva_insta/SS_correct_sequence_ReadData_ap /Top_WRAPPER/WRAPPER_insta/wrap_sva_insta/SS_correct_sequence_write_ap
coverage save ucdb_WRAPPER.ucdb -du Wrapper -onexit
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/agent/driver/stim_seq_item
run -all
coverage report -detail -cvg -directive -comments -output fcover_WRAPPER.txt {}