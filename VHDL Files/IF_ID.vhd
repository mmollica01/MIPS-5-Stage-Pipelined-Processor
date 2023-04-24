library ieee;
use ieee.std_logic_1164.all;

entity IF_ID is
port ( D_pc : in std_logic_vector(31 downto 0);
       D_im : in std_logic_vector(31 downto 0);
		 clk  : in std_logic;
		 Q_pc : out std_logic_vector(31 downto 0);
		 Q_im : out std_logic_vector(31 downto 0));
end entity;

architecture Behave of IF_ID is
begin
	process (clk)
	begin
		if rising_edge(clk) then
			Q_pc <= D_pc;
			Q_im <= D_im;
		end if;
	end process;		
end architecture;