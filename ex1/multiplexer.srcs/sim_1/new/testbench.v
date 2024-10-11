`timescale 1ns/1ps        

module multiplexer_sim();   

    wire enable;
    wire select;
    wire [3:0] input_a;
    wire [3:0] input_b;
    wire [3:0] led;
    
    reg [9:0] switch       ;

   initial    
   begin
        #0 switch = 10'b0_1_0010_0001;   // test enable = 0  
		#5 switch = 10'b0_0_0010_0001;
		
		#5 switch = 10'b1_0_0001_0000;   //test enable = 1, a+b
		#5 switch = 10'b1_0_0001_0001;
		#5 switch = 10'b1_0_1000_0100;
		#5 switch = 10'b1_0_0100_0001;
		
		#5 switch = 10'b1_1_0001_0000;   // test enable = 1, a-b
		#5 switch = 10'b1_1_0001_0001;
		#5 switch = 10'b1_1_1000_0100;
		#5 switch = 10'b1_1_0100_0001;
        #10 $finish ;                                
   end
   

   assign {enable, select, input_a, input_b} = switch;   // 使用位拼接符统一赋值
   
   multiplexer u_multiplexer (
        .enable (enable),
        .select (select),
        .input_a(input_a),
        .input_b(input_b),
        .led    (led   )
    );
endmodule

