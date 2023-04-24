library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branchAdd is
port ( PC        : in std_logic_vector(31 downto 0);
		 Immediate : in std_logic_vector(31 downto 0);
		 output    : out std_logic_vector(31 downto 0));
end entity;

architecture Behave of branchAdd is
begin
	output <= std_logic_vector(unsigned(PC) + unsigned(Immediate(30 downto 0) & '0'));
end architecture;