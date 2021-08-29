onerror {resume}
quietly virtual signal -install /gputestbench/MS { (context /gputestbench/MS )(CS_N & RAS_N & CAS_N & WE_N )} CMD
quietly virtual signal -install /gputestbench/MS { (context /gputestbench/MS )(FREE_RANGE & HORIZONTAL_FREE_RANGE & VERTICAL_FREE_RANGE )} FREERANGE
quietly virtual signal -install /gputestbench/MS { (context /gputestbench/MS )(VISIBLE_AREA & HORIZONTAL_VISIBLE_AREA & VERTICAL_VISIBLE_AREA )} VISIBLEAREA
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix symbolic /gputestbench/MS/clk
add wave -noupdate -radix symbolic /gputestbench/MS/rst
add wave -noupdate -radix symbolic /gputestbench/MS/ready
add wave -noupdate -radix symbolic /gputestbench/MS/WR
add wave -noupdate -radix symbolic /gputestbench/MS/RD
add wave -noupdate -radix symbolic /gputestbench/MS/WRreq
add wave -noupdate -radix symbolic /gputestbench/MS/RDreq
add wave -noupdate -radix symbolic /gputestbench/MS/FC
add wave -noupdate -radix unsigned /gputestbench/MS/color
add wave -noupdate -radix unsigned /gputestbench/MS/O
add wave -noupdate -radix unsigned /gputestbench/MS/opX
add wave -noupdate -radix unsigned /gputestbench/MS/opY
add wave -noupdate -radix unsigned /gputestbench/MS/syncX
add wave -noupdate -radix unsigned /gputestbench/MS/syncY
add wave -noupdate -radix unsigned /gputestbench/MS/memX
add wave -noupdate -radix unsigned /gputestbench/MS/memY
add wave -noupdate -radix symbolic /gputestbench/MS/SDRAM_DQ
add wave -noupdate -radix symbolic /gputestbench/MS/SDRAM_CTRL
add wave -noupdate -radix symbolic /gputestbench/MS/CMD
add wave -noupdate -radix unsigned /gputestbench/MS/ADDR
add wave -noupdate -radix symbolic /gputestbench/MS/BA
add wave -noupdate -radix symbolic /gputestbench/MS/actbank
add wave -noupdate -radix symbolic /gputestbench/MS/pre_bank
add wave -noupdate -radix symbolic /gputestbench/MS/FREERANGE
add wave -noupdate -radix symbolic /gputestbench/MS/VISIBLEAREA
add wave -noupdate -group Other -radix symbolic /gputestbench/MS/CKE
add wave -noupdate -group Other -radix symbolic /gputestbench/MS/FC_RD
add wave -noupdate -group Other -radix symbolic /gputestbench/MS/FC_WR
add wave -noupdate -radix symbolic /gputestbench/MS/last_line
add wave -noupdate -radix symbolic /gputestbench/MS/lastBank
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/no_read
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/read_guard
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/rd256_guard
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/rd32_guard
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/readComplete
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/no_write
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/write_guard
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/decReadCounter
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/ldReadCounter
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/RD_BUS
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/WR_BUS
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/rd_ADDR
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/rd_Command
add wave -noupdate -expand -group Todo /gputestbench/MS/wr_ADDR
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/wr_Command
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/init_ADDR
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/init_Command
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/va_ADDR
add wave -noupdate -expand -group Todo -radix symbolic /gputestbench/MS/va_Command
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/initrom_ba
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/initrom_bruncnd
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/readrom_ba
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/readrom_cc
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/writerom_ba
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/writerom_brno_write
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/writerom_brnot_ready
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/writerom_bruncnd
add wave -noupdate -group Roms -radix symbolic /gputestbench/MS/writerom_cc
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_0
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_1
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_2
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_3
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_4
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_5
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_6
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_7
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_8
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_9
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_10
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_11
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_12
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_64
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_65
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_66
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_19
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_20
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_67
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_68
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_69
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_70
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_71
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_24
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_72
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_73
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_74
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_28
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_40
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_41
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_42
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_43
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_44
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_45
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_46
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_47
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_48
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_49
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_50
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_51
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_52
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_53
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_54
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_55
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_56
add wave -noupdate -group SynthWires /gputestbench/MS/SYNTHESIZED_WIRE_57
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_0
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_1
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_2
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_3
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_4
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_5
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_6
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_7
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_8
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_9
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_10
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_11
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_12
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_13
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_14
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_15
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_16
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_17
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_18
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_19
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_20
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_21
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_22
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_23
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_24
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_25
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_26
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_27
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_28
add wave -noupdate -group TempSignals /gputestbench/MS/GDFX_TEMP_SIGNAL_29
add wave -noupdate -radix symbolic /gputestbench/H_SYNC
add wave -noupdate -radix symbolic /gputestbench/V_SYNC
add wave -noupdate -radix symbolic /gputestbench/VIDEO_OUTPUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {497118396 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 236
configure wave -valuecolwidth 143
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 5000
configure wave -gridperiod 10000
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {7675977750 ps}
