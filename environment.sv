class environment;

  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard scb;
  coverage   cov;
  
  mailbox #(transaction) gen2driv;
  mailbox #(transaction) mon2scb;
  mailbox #(transaction) mon2cov;
  
  virtual apb_if vif;

  function new(virtual apb_if vif);
    this.vif = vif;
    
    // THIS '1' forces the generator 
    // to pause until the driver finishes wiggling the pins.
    gen2driv = new(1); 
    
    mon2scb  = new();
    mon2cov  = new();
    
    gen  = new(gen2driv);
    driv = new(vif, gen2driv);
    mon  = new(vif, mon2scb, mon2cov);
    scb  = new(mon2scb);
    cov  = new(mon2cov);
  endfunction

  task test();
    fork
      gen.main();
      driv.main();
      mon.main();
      scb.main();
      cov.main();
    join_any 
  endtask

  task run();
    test();
    
    wait(gen.ended.triggered); 
  #100;
  endtask
endclass