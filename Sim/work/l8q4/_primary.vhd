library verilog;
use verilog.vl_types.all;
entity l8q4 is
    port(
        gip1            : out    vl_logic;
        gip2            : out    vl_logic;
        gip3            : out    vl_logic;
        gip4            : out    vl_logic;
        reqa            : in     vl_logic;
        reqb            : in     vl_logic;
        reqc            : in     vl_logic;
        reqd            : in     vl_logic;
        clk             : in     vl_logic
    );
end l8q4;
