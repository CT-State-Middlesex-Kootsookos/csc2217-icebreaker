module debounce(
    input wire clock,
    input wire IN,
    output reg OUT
);

 parameter M = 26;
 reg [M:0] shift;
 //shift: wait for stable
 always @ (posedge clock) 
 begin
   shift <= {shift,IN}; // N shift register
   if(~|shift)
     OUT <= 1'b0;
   else if(&shift)
     OUT <= 1'b1;
   else OUT <= OUT;
 end
 endmodule