----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2017 06:10:03 PM
-- Design Name: 
-- Module Name: display - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2017 05:52:45 PM
-- Design Name: 
-- Module Name: display - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
  Port ( 
  X: in STD_LOGIC_VECTOR(7 downto 0);
  Y: in STD_LOGIC_VECTOR(7 downto 0);
  Clk: in STD_LOGIC;
  Rst: in STD_LOGIC;
  Start: in STD_LOGIC;
  Term: out STD_LOGIC;
  An: out STD_LOGIC_VECTOR(7 downto 0);
  Seg: out STD_LOGIC_VECTOR(7 downto 0)
  );
end display;

architecture Behavioral of display is

signal data:STD_LOGIC_VECTOR(31 downto 0);
signal result: STD_LOGIC_VECTOR(15 downto 0);
begin

data(31 downto 24) <= X;
data(23 downto 16) <= Y;
data(15 downto 0) <= result;

mult: entity WORK.inmultire port map(Clk, Rst, Start, X, Y, result(15 downto 8), result(7 downto 0), term);
display: entity WORK.displ7seg port map(Clk, Rst, data, An, Seg);

end Behavioral;

