module top;
  logic pclk;
  logic presetn;

  // Clock generation
  initial pclk = 0;
  always #5 pclk = ~pclk;

 
  apb_if intf();

  // Connect top-level clock & reset to interface logic
  assign intf.pclk    = pclk;
  assign intf.presetn = presetn;

  // DUT instance
  apb_s dut (
    .pclk(intf.pclk),
    .presetn(intf.presetn),
    .paddr(intf.paddr),
    .psel(intf.psel),
    .penable(intf.penable),
    .pwrite(intf.pwrite),
    .pwdata(intf.pwdata),
    .prdata(intf.prdata),
    .pready(intf.pready),
    .pslverr(intf.pslverr)
  );

  environment env;

  initial begin
    presetn = 0;
    #15 presetn = 1;

    env = new(intf);
    env.gen.repeat_count = 1000;
    env.run();

    $display("Test finished! Coverage = %0f%%", env.cov.apb_cg.get_coverage());
    $finish;
  end
  
endmodule