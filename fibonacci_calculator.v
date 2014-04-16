/**
 * module name: fibonacci_calculator.v
 * author: Andrei Thompson
 * PID: A09597901
 */

module fibonacci_calculator(input_s, reset_n, begin_fibo, clk, done, fibo_out);
	input [4:0] input_s;
	input reset_n;
	input begin_fibo; //Start calculation
	input clk;
	
	output done;
	output [15:0] fibo_out;
	
	
	
	reg [15:0] curr_sum_r, last_sum_r;
	reg active_r;
	reg [4:0] counter_r;
	
	wire [15:0] curr_sum_n;
	wire [4:0] counter_n;
	wire active_n;
	
	
	//combinational logic:
	assign fibo_out = curr_sum_r; //set the output value to be the curr_sum register
	assign done = active_n ? 1'b0 : 1'b1; //check if we are done or not
	assign counter_n = counter_r + 1; //set next counter value
	assign active_n = (counter_n == input_s)? 1'b0 : 1'b1; //check if we are active;
	assign curr_sum_n = last_sum_r + curr_sum_r; // calculate the next sum
	
	//sequential logic:
	always @ (posedge clk or negedge reset_n)
	begin
		if(!reset_n)
		begin
			//reset all registers
			curr_sum_r <= 1;
			last_sum_r <= 0;
			counter_r <= 0;
			active_r <= 1'b0;
		end
		else
		begin
			//check if begin signal has come:
			if(begin_fibo && ~active_n) active_r <= 1'b1;
			else
			begin
				// pass next data to registers if in active state:
				if(active_n)
				begin
					curr_sum_r <= curr_sum_n; //get next sum
					last_sum_r <= curr_sum_r; //send curr_sum down
					counter_r <= counter_n; // increment counter
					active_r <= active_n; //set next active state
				end
			end
		end
	end


endmodule