class scoreboard;
  mailbox #(transaction) mon2scb;
  bit [7:0] mem_model [int]; 

  function new(mailbox #(transaction) mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task main();
    transaction trans;
    forever begin
      mon2scb.get(trans);
      
      // 1. Check for Out-of-Bounds Error
      if (trans.paddr > 15) begin
        if (trans.pslverr === 1) 
          $display("[SCOREBOARD] PASS: Out-of-bound access correctly generated slave error. Addr=%0d", trans.paddr);
        else 
          $error("[SCOREBOARD] FAIL: Missing expected slave error! Addr=%0d", trans.paddr);
      end 
      
      // 2. Handle Valid Writes
      else if (trans.pwrite) begin
        mem_model[trans.paddr] = trans.pwdata; 
        $display("[SCOREBOARD] WRITE: Stored Data=%h at Addr=%0d in golden model.", trans.pwdata, trans.paddr);
      end 
      
      // 3. Handle Valid Reads
      else begin
        // Check if the address has been written to previously
        if (mem_model.exists(trans.paddr)) begin
          if (trans.prdata === mem_model[trans.paddr]) 
            $display("[SCOREBOARD] PASS: Read match! Addr=%0d, Expected=%h, Actual=%h", trans.paddr, mem_model[trans.paddr], trans.prdata);
          else 
            $error("[SCOREBOARD] FAIL: Read mismatch! Addr=%0d, Expected=%h, Actual=%h", trans.paddr, mem_model[trans.paddr], trans.prdata);
        end 
        else begin
          // If reading an uninitialized address, just log it (assuming DUT returns 0 or X)
          $display("[SCOREBOARD] INFO: Read from uninitialized Addr=%0d. Actual=%h", trans.paddr, trans.prdata);
        end
      end
      
      $display("------------------------------------------------------");
    end
  endtask
endclass