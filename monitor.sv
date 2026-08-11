class monitor;
  virtual apb_if vif;
  mailbox #(transaction) mon2scb;
  mailbox #(transaction) mon2cov;

  function new(virtual apb_if vif, mailbox #(transaction) mon2scb, mailbox #(transaction) mon2cov);
    this.vif = vif;
    this.mon2scb = mon2scb;
    this.mon2cov = mon2cov;
  endfunction

  task main();
    forever begin
      @ (posedge vif.pclk);
      if (vif.psel && vif.penable && vif.pready) begin
        transaction trans = new();
        trans.paddr   = vif.paddr;
        trans.pwrite  = vif.pwrite;
        trans.pwdata  = vif.pwdata;
        trans.prdata  = vif.prdata;
        trans.pslverr = vif.pslverr;
        
        trans.display("MONITOR");
        
        mon2scb.put(trans);
        mon2cov.put(trans);
      end
    end
  endtask
endclass