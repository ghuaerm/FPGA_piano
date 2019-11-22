// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Beeper
// 
// Author: Step
// 
// Description: Beeper
// 
// Web: www.stepfapga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Beeper
(
input					clk_in,
input					rst_n_in,
input					tone_en,
input			[15:0]	tone,
output	reg				piano_out
);

reg [15:0] time_end;
//transfer tone to time_end
always@(tone) begin
	case(tone)
		16'h0001:	time_end <=	16'd22930;	//M1,
		16'h0002:	time_end <=	16'd20430;	//M2,
		16'h0004:	time_end <=	16'd18200;	//M3,
		16'h0008:	time_end <=	16'd17180;	//M4,
		16'h0010:	time_end <=	16'd15305;	//M5,
		16'h0020:	time_end <=	16'd13635;	//M6,
		16'h0040:	time_end <=	16'd12148;	//M7,
		16'h0080:	time_end <=	16'd11477;	//H1,
		16'h0100:	time_end <=	16'd10215;	//H2,
		16'h0200:	time_end <=	16'd9101;	//H3,
		16'h0400:	time_end <=	16'd8590;	//H4,
		16'h0800:	time_end <=	16'd7653;	//H5,
		16'h1000:	time_end <=	16'd6818;	//H6,
		16'h2000:	time_end <=	16'd6075;	//H7,
		16'h4000:	time_end <=	16'd22930;	//M1,
		16'h8000:	time_end <=	16'd20430;	//M2,
		default:time_end <=	16'd65535;	
	endcase
end

reg [17:0] time_cnt;
//count for different tone
always@(posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		time_cnt <= 1'b0;
	end else if(!tone_en) begin
		time_cnt <= 1'b0;
	end else if(time_cnt>=time_end) begin
		time_cnt <= 1'b0;
	end else begin
		time_cnt <= time_cnt + 1'b1;
	end
end
	
//generate piano signal
always@(posedge clk_in or negedge rst_n_in) begin
	if(!rst_n_in) begin
		piano_out <= 1'b1;
	end else if(time_cnt==time_end) begin
		piano_out <= ~piano_out;
	end else begin
		piano_out <= piano_out;
	end
end
	
endmodule