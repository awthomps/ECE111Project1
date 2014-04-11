module fibonacci_calculator(input_s, reset_n, begin_fibo, clk, done, fibo_out);
	input [4:0] input_s;
	input reset_n;
	input begin_fibo; //Start calculation
	input clk;
	
	output done;
	output [15:0] fibo_out;
	
	
	wire [15:0] curr_sum_n;
	reg [15:0] curr_sum_r, last_sum_r;
	reg active_r, done_r;
	integer counter, counter_n;
	wire active_n;
	
	
	
	assign fibo_out = curr_sum_r;
	assign done = done_r;
	assign active_n = (counter != input_s); //check if we are active;
	assign curr_sum_n = last_sum_r + curr_sum_r;
	
	always@ (*)
	begin
		
	end
	
	always @ (posedge clk)
	begin
		if(reset_n == 1)
		begin
			curr_sum_r <= 1;
			last_sum_r <= 0;
			counter <= 1;
			active_r <= 0;
			done_r <= 0;
		end
		else
		begin
			//check if begin signal has come:
			if(begin_fibo) active_r <= 1;
			else
			begin
				if(active_r)
				begin
					curr_sum_r <= curr_sum_n; //get next sum
					last_sum_r <= curr_sum_r; //send curr_sum down
					counter <= counter_n; // increment counter
					active_r <= active_n;
					done_r <= (~active_n & ~ begin_fibo);
				end
			end
		end
	end


endmodule