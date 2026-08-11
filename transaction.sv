class transaction;
  // Randomize inputs
  rand bit [31:0] paddr;
  rand bit        pwrite;
  rand bit [7:0]  pwdata;
  
  // Outputs captured from DUT
  bit [7:0] prdata;
  bit       pslverr;

  // Constrain address to test both valid (0-15) and error bounds
  constraint c_addr { paddr dist { [0:15]:/80, [16:30]:/20 }; }
  
  function void display(string name);
    $display("[%s] Addr=%0d, Write=%b, WData=%h, RData=%h, Err=%b", 
             name, paddr, pwrite, pwdata, prdata, pslverr);
  endfunction
endclass