// pulse_gen - gen pulse data for simulation
// Bill Burris, Jan 9, 2008
// modified by SL, March7,2016
// description: generate an exponential decay signal for simulation purpose, non-synthesizable


`timescale 1 ns / 1 ps

module pulse_gen( dclk, reset, enable, db );
    
    parameter adc_width = 16;
    
   input dclk;
   input reset;
   input enable;
   output [adc_width-1:0] db;
    
   parameter Max_Current_Points = 10;
   parameter Total_Charge = 0.7e-12;
   parameter Cf = 2e-12;
   parameter Rf = 0.5e+2;
   parameter Delta_T = 20.0e-9;
    
   wire dclk;
   wire reset;
   reg [adc_width-1:0] db;
     
   real i, current, Vn, Vn1;
   real Q, Qc, Qd;

   always @(posedge dclk)
   begin
       if( reset == 0 )
       begin
           Vn = 0;
           i = 0;
           db = 0;
       end
       else
       begin
           if( enable == 1 )
           begin
              if (i < Max_Current_Points)
              begin
                 current = Total_Charge / (Max_Current_Points * Delta_T);
                 i = i + 1;
              end
              else
              begin
                 current = 0;
              end
              Qc = current * Delta_T * 1.0e-9 * 1.0e-9; //in Coulomb
              Qd = (Vn / Rf) * Delta_T * 1.0e-6 * 1.0e-9; //in Coulomb
              Q = Q + (Qc - Qd);
              Vn1 = (Q / Cf) * 1.0e+12;
              db = Vn * 1.0e6 * 4095;
              Vn = Vn1;
           end
           else
           begin
               db = 0;
           end
        end
    end

endmodule