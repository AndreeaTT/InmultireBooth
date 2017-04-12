----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2017 10:53:11 AM
-- Design Name: 
-- Module Name: booth - Behavioral
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

entity booth is
  generic(n: natural);
  Port (
  clk:in std_logic;
  rst:in std_logic;
  start:in std_logic;
  q0:in std_logic;
  q_1: in std_logic;
  
  term:out std_logic;
  loadbq:out std_logic;
  rstaq_1: out std_logic;
  shifta: out std_logic;
  subb:out std_logic;
  loada:out std_logic
  );
end booth;

architecture Behavioral of booth is

type tip_stare is (idle, init, test, scadere, adunare, decrm, result);
signal stare: tip_stare;
signal c:natural;

begin
proc1:  process(clk,rst, start, q0, q_1)
        begin
          if rising_edge(clk) then
            if (rst = '1') then
                stare <= idle;
                term <= '-';
                loadbq <= '-';
                rstaq_1 <= '-';
                subb <= '-';
                loada <= '-';
                shifta <= '-';
            else
                case stare is
                    when idle => 
                          term <= '0';
                          loadbq <= '0';
                          rstaq_1 <= '1';
                          subb <= '0';
                          loada <= '0';
                          shifta <= '0'; 
                         
                         if (start = '1') then
                            stare <= init;
                         else
                            stare <= idle;
                         end if; 
                         
                  when init => 
                         term <= '0';
                         loadbq <= '1';
                         rstaq_1 <= '1';
                         subb <= '0';
                         loada <= '0';
                         shifta <= '0'; 
                         c <= n + 1;
                         stare <= test;
                      
                  when test => 
                         term <= '0';
                         loadbq <= '0';
                         rstaq_1 <= '0';
                         subb <= '0';
                         loada <= '0';
                         shifta <= '0'; 
                                                  
                         if (q0 = '1' and q_1 = '0') then
                               stare <= scadere;
                         else
                            if (q0 = '0'and q_1 = '1') then
                               stare <= adunare;
                            else
                               stare <= decrm; 
                            end if;
                         end if;                               
                       
                  when adunare => 
                            term <= '0';
                            loadbq <= '0';
                            rstaq_1 <= '0';
                            subb <= '0';
                            loada <= '1';
                            shifta <= '0'; 
                                                  
                            stare <= decrm;
                            
                 when scadere => 
                            term <= '0';
                            loadbq <= '0';
                            rstaq_1 <= '0';
                            subb <= '1';
                            loada <= '1';
                            shifta <= '0';
                            
                            stare <= decrm;
                            
                 when decrm => 
                            term <= '0';
                            loadbq <= '0';
                            rstaq_1 <= '0';
                            subb <= '0';
                            loada <= '0';
                            shifta <= '1'; 
                            c <= c-1;
                                                     
                            if (c >0) then
                                stare <= test;
                            else
                                stare <= result;
                            end if;      
                           
                  when result => 
                             term <= '1';
                             loadbq <= '0';
                             rstaq_1 <= '0';
                             subb <= '0';
                             loada <= '0';
                             shifta <= '0';                        
                             stare <= idle;
             end case;
                                                                               
            end if;
         end if;
end process proc1;
end Behavioral;
