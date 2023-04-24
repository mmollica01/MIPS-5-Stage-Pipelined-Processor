library ieee;
use ieee.std_logic_1164.all;

entity PC is 
port( pc_in : in std_logic_vector(31 downto 0);
      clk   : in std_logic;
      pc_out: out std_logic_vector(31 downto 0) := x"00000000"
    );
end entity PC;

architecture PC_arch of PC is
    begin
        process(clk)
        begin
            if rising_edge(clk) then
                pc_out <= pc_in;
            end if;
        end process;
end architecture PC_arch;