///////////////////coverage//////////////

class coverage;

  transaction tr;

  covergroup apb_cov;

    // Address Coverage
    cp_addr : coverpoint tr.paddr
    {
      bins low_addr[] = {[0:7]};
      bins high_addr[] = {[8:15]};
    }

    // Read / Write Coverage
    cp_write : coverpoint tr.pwrite
    {
      bins READ  = {0};
      bins WRITE = {1};
    }

    // Data Coverage
    cp_data : coverpoint tr.pwdata
    {
      bins low  = {[0:63]};
      bins mid  = {[64:127]};
      bins high = {[128:191]};
      bins max  = {[192:255]};
    }

    // Error Coverage
    cp_error : coverpoint tr.pslverr
    {
      bins no_error = {0};
      bins error    = {1};
    }

    // Cross Coverage
    addr_x_rw : cross cp_addr, cp_write;

  endgroup

  function new();
    apb_cov = new();
  endfunction

endclass