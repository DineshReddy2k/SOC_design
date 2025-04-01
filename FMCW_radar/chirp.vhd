library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity phase_logic is
port(
clk : in std_logic;
rst : in std_logic;

start : in std_logic_vector(31 downto 0);
stop : in std_logic_vector(31 downto 0);
step : in std_logic_vector(31 downto 0);

phase_out : out std_logic_vector(31 downto 0);
phase_valid : out std_logic;
phase_last : out std_logic
);
end phase_logic;

architecture Behavioral of phase_logic is

    type state_type is (IDLE, CALCULATE, GENERATE_LFM);
    signal state        : state_type := IDLE;
    signal sample_count : unsigned(31 downto 0) := (others => '0');
    signal start_freq : std_logic_vector(31 downto 0) := (others => '0');
    signal stop_freq    : std_logic_vector(31 downto 0) := (others => '0');
    signal step_freq    : std_logic_vector(31 downto 0) := (others => '0');
    signal phase_out_i    : std_logic_vector(31 downto 0) := (others => '0');
    signal phase_inc    : std_logic_vector(31 downto 0) := (others => '0');
                          
begin
    
    phase_out <= phase_out_i;
    
    process(clk)
    begin

        if rising_edge(clk) then
           if rst = '0' then
            state <= IDLE;
            phase_out_i <= (others => '0');
            sample_count <= (others => '0');
            phase_valid <= '0';
            else
            
                case state is
                    when IDLE =>
                        phase_valid <= '0';
                        phase_last <= '0';
                        phase_out <= (others => '0');
                        
                        phase_out_i <= start;
                        phase_inc <= step;
                    
                    when CALCULATE =>
                        state <= GENERATE_LFM;
                        sample_count <= (others => '0');
                        phase_valid <= '1';
                        phase_out <= phase_out_i + phase_inc;
                        
                    when GENERATE_LFM =>
                        if sample_count >= unsigned(time) then
                            phase_last <= '1';
                            state <= IDLE;                          
                        else
                            phase_out_i <= phase_out_i + phase_inc;
                            sample_count <= sample_count + 1;         
                        end if;
                end case;
            end if;
        end if;
    end process; 
    
end Behavioral;
