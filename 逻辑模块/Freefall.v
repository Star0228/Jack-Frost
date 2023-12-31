module FreeFall(
    input wire clk,    // clock signal
    input wire [8:0] yInit, vInit,  // Initial position and velocity 
    output reg [8:0] y, v    // Position and velocity after one time step
);
    // Assume the time step is 1 time unit (for example, second) for simplicity
    parameter g = 9'd14; // gravity * 1.5 (to fit into 9 bits), real value is 9.8

    always @(posedge clk) begin
        // calculate next y position using kinematics equation: y = yInit + vInit*t - 1/2*g*t*t
        // here we assume: t = 1, to keep the calculation within integer precision
        y <= yInit + vInit - (g / 2);
        // calculate next v: v = vInit - g*t
        v <= vInit - g;
    end
endmodule