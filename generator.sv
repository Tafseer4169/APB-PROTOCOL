class generator;
  transaction trans;
  mailbox #(transaction) gen2driv;
  int repeat_count; // How many packets to generate
  event ended;      // Signal when done generating

  function new(mailbox #(transaction) gen2driv);
    this.gen2driv = gen2driv;
  endfunction

  task main();
    for (int i = 0; i < repeat_count; i++) begin
      trans = new();
      if (!trans.randomize()) $fatal("Randomization failed");
      gen2driv.put(trans);
    end
    -> ended; // Trigger event when finished
  endtask
endclass
