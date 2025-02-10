library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port (
        Clk       : in  STD_LOGIC;                      -- Clock signal
        RegWrite  : in  STD_LOGIC;                      -- Write enable signal
        ReadReg1  : in  STD_LOGIC_VECTOR (1 downto 0);  -- Read register 1 address
        ReadReg2  : in  STD_LOGIC_VECTOR (1 downto 0);  -- Read register 2 address
        WriteReg  : in  STD_LOGIC_VECTOR (1 downto 0);  -- Write register address
        WriteData : in  STD_LOGIC_VECTOR (7 downto 0);  -- Data to write
        ReadData1 : out STD_LOGIC_VECTOR (7 downto 0);  -- Output data from register ReadReg1
        ReadData2 : out STD_LOGIC_VECTOR (7 downto 0)   -- Output data from register ReadReg2
    );
end RegisterFile;

architecture Behavioral of RegisterFile is	  
    -- 4 8-bit register
    type reg_array is array (0 to 3) of STD_LOGIC_VECTOR (7 downto 0);
    signal registers : reg_array := (others => (others => '0'));  -- first zero initializing

    -- 2-to-4 decoder
    signal decoder_out : STD_LOGIC_VECTOR (3 downto 0);
begin
    -- reading data
    ReadData1 <= registers(to_integer(unsigned(ReadReg1)));
    ReadData2 <= registers(to_integer(unsigned(ReadReg2)));

    -- selecting dest reg
    process (WriteReg)
    begin
        case WriteReg is
            when "00" => decoder_out <= "0001";
            when "01" => decoder_out <= "0010";
            when "10" => decoder_out <= "0100";
            when "11" => decoder_out <= "1000";
            when others => decoder_out <= "0000";
        end case;
    end process;

    -- writing in dest reg on rising edge clock
    process (Clk)
    begin
        if rising_edge(Clk) then
            if RegWrite = '1' then
                case decoder_out is
                    when "0001" => registers(0) <= WriteData;
                    when "0010" => registers(1) <= WriteData;
                    when "0100" => registers(2) <= WriteData;
                    when "1000" => registers(3) <= WriteData;
                    when others => null;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
