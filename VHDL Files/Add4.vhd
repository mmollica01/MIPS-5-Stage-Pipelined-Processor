library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Add4 is 
port( x_in  : in std_logic_vector(31 downto 0);
      z_out : out std_logic_vector(31 downto 0) 
    );
end entity Add4;

architecture Add4_arch of Add4 is
    signal one : std_logic_vector(31 downto 0) := x"00000001";
    begin
        z_out <= std_logic_vector(unsigned(x_in) + unsigned(one));
end architecture Add4_arch;