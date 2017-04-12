----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2017 11:36:19 AM
-- Design Name: 
-- Module Name: inmultire - Behavioral
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

entity inmultire is
  generic(n:natural := 8);
  Port (
   clk: in std_logic;
   rst: in std_logic;
   start: in std_logic;
   x: in std_logic_vector(n-1 downto 0);
   y: in std_logic_vector(n-1 downto 0);
   
   a:out std_logic_vector(n-1 downto 0);
   q:out std_logic_vector(n-1 downto 0);
   term: out std_logic
   );
end inmultire;

architecture Behavioral of inmultire is
signal b_load, b_temp: std_logic_vector(n-1 downto 0);
signal q_1, loadbq, subb, ovf, tout, shraq, rstaq_1, loada, rsta, term_aux:std_logic;
signal a_load, q_load, a_perm: std_logic_vector(n-1 downto 0);


begin

dut1: entity WORK.registrusincron generic map(n => 8)
                                  port map(x, loadbq, clk, rst, b_load);
                                  
dut2: entity WORK.addn generic map(n => 8)
                       port map(a_load, b_temp, subb, a_perm, tout, ovf);
                       
dut3: entity WORK.srrn generic map(n => 8)
                       port map(clk, y, a_load(0), rst, loadbq, shraq, q_load);
                       
dut4: entity WORK.srrn generic map(n => 8)
                       port map(clk, a_perm, a_load(n-1), rstaq_1, loada, shraq, a_load);
                                 
dut5: entity WORK.bistabilsincron port map(clk, shraq, rstaq_1, q_load(0), q_1);

dut6: entity WORK.booth generic map(n => 7)
                        port map(clk, rst, start, q_load(0), q_1, term_aux, loadbq, rstaq_1, shraq, subb, loada);
   
gen: for i in 0 to n-1 generate
    b_temp(i) <= b_load(i) xor subb;
end generate gen;
   
reza: entity WORK.registrusincron generic map(n => 8)
                                  port map(a_load, term_aux, clk, rst, a);

rezq: entity WORK.registrusincron generic map(n => 8)
                                  port map(q_load, term_aux, clk, rst, q);
                  
term <= term_aux;

end Behavioral;
