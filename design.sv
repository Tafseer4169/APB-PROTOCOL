module apb_s(
  
  input pclk,
  input presetn,
  input [31:0]paddr,
  input psel,
  input penable,
  input pwrite,
  input [7:0]pwdata,
  
  output reg [7:0]prdata,
  output reg pready,
  output pslverr
);
  
  localparam [1:0] idle = 0,write = 1, read = 2;
  
  reg [7:0]mem[16];
  
  reg[1:0] state,nstate;
  
  bit addr_err,addv_err,data_err;
  
  // addr_err = 1 when addr_range is greater than 16
  // addv_err = 1 when addr have x or z in addr value
  // data_Err = 1 when data have x or z value
  
  
  // reset decoder
  
  always @(posedge pclk or negedge presetn)begin
    if(!presetn)
      state <= idle;
    else 
      state <= nstate;
  end
  
  
  //next state and output decoder
  
  always @(*)begin
    case(state)
      
      idle : begin
        prdata = 8'h00;
        pready = 1'b0;
        
        if(psel == 1'b1 && pwrite == 1'b1)
          nstate = write;
        else if(psel == 1'b1 && pwrite == 1'b0)
          nstate = read;
        else
          nstate = idle;
        
      end
      
      write : begin
        
        if(psel == 1'b1 && penable == 1'b1)begin
          
          if(!addr_err && !addv_err && !data_err)
            begin
              pready = 1'b1;
              mem[paddr] = pwdata;
              nstate = idle;
            end
          else
            begin
              nstate = idle;
              pready = 1'b1;
            end
        end
        
      end
      
      read : begin
        
        if(psel == 1'b1 && penable == 1'b1)begin
          if(!addr_err && !addv_err && !data_err)
            begin
              pready = 1'b1;
              prdata = mem[paddr];
              nstate = idle;
            end
          else
            begin
              pready = 1'b1;
              prdata = 8'h00;
              nstate = idle;
            end
        end
        
      end
      
      default : begin
        
        nstate = idle;
        prdata = 8'h00;
        pready = 1'b0;
      end
      
    endcase
  end
  
  
  /////checking valid values of address and data//////
  
  reg av_t = 0;
  
  always @(*)begin
    if(paddr >= 0)
      av_t = 1'b0;
    else
      av_t = 1'b1;
  end
  
  reg dv_t = 0;
  
  always@(*)begin
    if(pwdata >= 0)
      dv_t = 1'b0;
    else
      dv_t = 1'b1;
  end
  
  always @(posedge pclk)
begin
    if(psel && penable)
    begin
        $display("ADDR=%0d PSLVERR=%0b addr_err=%0b",
                 paddr,pslverr,addr_err);
    end
end
  
  assign addr_err = ((nstate == write) || (nstate == read)) && (paddr > 15) ? 1'b1 : 1'b0;
  
  assign addv_err = ((nstate == write) || (nstate == read)) ? av_t : 1'b0;
  
  assign data_err = ((nstate == write) || (nstate == read)) ? dv_t : 1'b0;
  
  assign pslverr = (psel == 1'b1 && penable == 1'b1) ? (addv_err || addr_err || data_err) : 1'b0;
  
endmodule

interface abp_if;
  
  logic presetn;
  logic pclk;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] paddr, pwdata;
  logic [31:0] prdata;
  logic pready, pslverr;  
  
  
endinterface