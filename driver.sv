class driver;

  virtual apb_if vif;
  mailbox #(transaction) gen2driv;

  function new(virtual apb_if vif, mailbox #(transaction) gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction

  task main();
    forever begin
      transaction trans;
      gen2driv.get(trans);
      
      @ (posedge vif.pclk);
      // APB Setup Phase
      vif.psel    <= 1;
      vif.pwrite  <= trans.pwrite;
      vif.paddr   <= trans.paddr;
      vif.pwdata  <= trans.pwdata;
      vif.penable <= 0;
      
      @ (posedge vif.pclk);
      // APB Access Phase
      vif.penable <= 1;
      wait(vif.pready);
      
      @ (posedge vif.pclk);
      vif.psel    <= 0;
      vif.penable <= 0;
    end
  endtask
endclass
