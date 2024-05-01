module slow_clock(input wire CLK, output reg SLOW_CLK);

reg [31:0] counter;

always @(posedge CLK)
begin
    counter <= counter + 1;
    if (counter == 1_000_000)
    begin
        counter <= 0;
        SLOW_CLK <= ~SLOW_CLK;
    end
end


endmodule