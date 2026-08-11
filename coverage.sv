class coverage;
  mailbox #(transaction) mon2cov;
  transaction trans;

  covergroup apb_cg;
    c_addr: coverpoint trans.paddr {
      bins valid[] = {[0:15]};
      bins error   = {[16:$]};
    }
    c_op: coverpoint trans.pwrite {
      bins read  = {0};
      bins write = {1};
    }
    c_err: coverpoint trans.pslverr;
    
    cross_op_addr: cross c_op, c_addr;
  endgroup

  function new(mailbox #(transaction) mon2cov);
    this.mon2cov = mon2cov;
    apb_cg = new();
  endfunction

  task main();
    forever begin
      mon2cov.get(trans);
      apb_cg.sample();
    end
  endtask
endclass
