// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Array_KeyBoard
// 
// Author: Step
// 
// Description: Array_KeyBoard
// 
// Web: www.stepfapga.com
//
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2015/11/11   |Initial ver
// --------------------------------------------------------------------
module Array_KeyBoard #
(
	parameter			NUM_FOR_200HZ = 60000
)
(
	input				clk_in,
	input				rst_n_in,
	input		[3:0]	col,
	output	reg	[3:0]	row,
	output	reg	[15:0]	key_out,
	output		[15:0]	key_pulse
);
	
	localparam			STATE0 = 2'b00;
	localparam			STATE1 = 2'b01;
	localparam			STATE2 = 2'b10;
	localparam			STATE3 = 2'b11;

	//count for clk_200hz
	reg		[15:0]		cnt;
	reg					clk_200hz;
	always@(posedge clk_in or negedge rst_n_in) begin
		if(!rst_n_in) begin
			cnt <= 16'd0;
			clk_200hz <= 1'b0;
		end else begin
			if(cnt >= ((NUM_FOR_200HZ>>1) - 1)) begin
				cnt <= 16'd0;
				clk_200hz <= ~clk_200hz;
			end else begin
				cnt <= cnt + 1'b1;
				clk_200hz <= clk_200hz;
			end
		end
	end

	reg		[1:0]		c_state;
	always@(posedge clk_200hz or negedge rst_n_in) begin
		if(!rst_n_in) begin
			c_state <= STATE0;
			row <= 4'b1110;
		end else begin
			case(c_state)
				STATE0: begin c_state <= STATE1; row <= 4'b1101; end
				STATE1: begin c_state <= STATE2; row <= 4'b1011; end
				STATE2: begin c_state <= STATE3; row <= 4'b0111; end
				STATE3: begin c_state <= STATE0; row <= 4'b1110; end
				default:begin c_state <= STATE0; row <= 4'b1110; end
			endcase
		end
	end

	always@(negedge clk_200hz or negedge rst_n_in) begin
		if(!rst_n_in) begin
			key_out <= 16'hffff;
		end else begin
			case(c_state)
				STATE0:key_out[3:0] <= col;
				STATE1:key_out[7:4] <= col;
				STATE2:key_out[11:8] <= col;
				STATE3:key_out[15:12] <= col;
				default:key_out <= 16'hffff;
			endcase
		end
	end
	
	reg		[15:0]		key_out_r;
	//Register key_out_r, lock key_out to next clk
	always @ ( posedge clk_in  or  negedge rst_n_in )
		if (!rst_n_in) key_out_r <= 16'hffff;
		else  key_out_r <= key_out;

	//wire	[15:0]		 key_pulse;
	//Detect the negedge of key_out, generate pulse
	assign key_pulse= key_out_r & ( ~key_out);

endmodule
