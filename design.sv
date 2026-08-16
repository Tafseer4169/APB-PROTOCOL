module apb_s (
  input             pclk,
  input             presetn,
  input      [31:0] paddr,
  input             psel,
  input             penable,
  input             pwrite,
  input      [7:0]  pwdata,

  output reg [7:0]  prdata,
  output reg        pready,
  output            pslverr
);

  // 16-byte memory
  reg [7:0] mem[0:15];

  // Direct error detection logic evaluated combinationally during ACCESS phase
  wire addr_err = (paddr > 15);
  wire addv_err = $isunknown(paddr);
  wire data_err = pwrite && $isunknown(pwdata); 

  // Asserting pslverr 
  assign pslverr = (psel && penable) && (addr_err || addv_err || data_err);


  always @(posedge pclk or negedge presetn) begin
    if (!presetn) begin
      pready <= 1'b0;
      prdata <= 8'h00;
    end else begin
      if (psel && !penable) begin
        // Setup Phase
        pready <= 1'b0;
      end else if (psel && penable) begin
        // Access Phase
        pready <= 1'b1;
        
        if (!pslverr) begin
          if (pwrite) begin
            mem[paddr[3:0]] <= pwdata; // Sequential Memory Write
          end else begin
            prdata <= mem[paddr[3:0]]; // Sequential Memory Read
          end
        end else begin
          prdata <= 8'h00; // Return zero on slave error
        end
      end else begin
        pready <= 1'b0;
      end
    end
  end

endmodule


interface apb_if;

  logic pclk;
  logic presetn;
  logic [31:0] paddr;
  logic psel;
  logic penable;
  logic pwrite;
  
  logic [7:0] pwdata;
  logic [7:0] prdata;
  logic pready;
  logic pslverr;

endinterface
