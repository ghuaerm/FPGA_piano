// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Electric_Piano
// 
// Author: Step
// 
// Description: Electric_Piano
// 
// Web: www.stepfapga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Electric_Piano
(
input					clk_in,			//system clock
input					rst_n_in,		//system reset
input			[3:0]	col,
output			[3:0]	row,
output					piano_out
);

wire			[15:0]	key_out;
wire			[15:0]	key_pulse;
//Array_KeyBoard 
Array_KeyBoard Array_KeyBoard_uut
(
.clk_in					(clk_in			),
.rst_n_in				(rst_n_in		),
.col					(col			),
.row					(row			),
.key_out				(key_out		),
.key_pulse				(key_pulse		)
);

wire					tone_en = (~key_out[15:0])?1'b1:1'b0;
wire			[15:0]	tone = (~key_out);

//beeper module
Beeper Beeper_uut
(
.clk_in					(clk_in			),
.rst_n_in				(rst_n_in		),
.tone_en				(tone_en		),
.tone					(tone			),
.piano_out				(piano_out		)
);

endmodule