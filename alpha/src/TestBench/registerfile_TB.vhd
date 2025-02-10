library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity registerfile_tb is
end registerfile_tb;

architecture TB_ARCHITECTURE of registerfile_tb is
	-- Component declaration of the tested unit
	component registerfile
	port(
		Clk : in STD_LOGIC;
		RegWrite : in STD_LOGIC;
		ReadReg1 : in STD_LOGIC_VECTOR(1 downto 0);
		ReadReg2 : in STD_LOGIC_VECTOR(1 downto 0);
		WriteReg : in STD_LOGIC_VECTOR(1 downto 0);
		WriteData : in STD_LOGIC_VECTOR(7 downto 0);
		ReadData1 : out STD_LOGIC_VECTOR(7 downto 0);
		ReadData2 : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Clk : STD_LOGIC;
	signal RegWrite : STD_LOGIC;
	signal ReadReg1 : STD_LOGIC_VECTOR(1 downto 0);
	signal ReadReg2 : STD_LOGIC_VECTOR(1 downto 0);
	signal WriteReg : STD_LOGIC_VECTOR(1 downto 0);
	signal WriteData : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ReadData1 : STD_LOGIC_VECTOR(7 downto 0);
	signal ReadData2 : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...				
	-- Clock period definition
	constant Clk_period : time := 10 ns;

begin

	-- Unit Under Test port map
	 uut: registerfile port map (
        Clk       => Clk,
        RegWrite  => RegWrite,
        ReadReg1  => ReadReg1,
        ReadReg2  => ReadReg2,
        WriteReg  => WriteReg,
        WriteData => WriteData,
        ReadData1 => ReadData1,
        ReadData2 => ReadData2
    );

	-- Add your stimulus here ...	  
	 -- Clock process
    Clk_process: process
    begin
        while now < 100 ns loop
            Clk <= '0';
            wait for Clk_period/2;
            Clk <= '1';
            wait for Clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Write to register 0
        RegWrite  <= '1';
        WriteReg  <= "00";
        WriteData <= x"AA";
        wait for Clk_period;
        
        -- Write to register 1
        WriteReg  <= "01";
        WriteData <= x"BB";
        wait for Clk_period;
        
        -- Disable write
        RegWrite  <= '0';
        
        -- Read from register 0 and 1
        ReadReg1 <= "00";
        ReadReg2 <= "01";
        wait for Clk_period;
        
        -- Read from an unwritten register (should return 0)
        ReadReg1 <= "10";
        ReadReg2 <= "11";
        wait for Clk_period;
        
        wait;
    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_registerfile of registerfile_tb is
	for TB_ARCHITECTURE
		for UUT : registerfile
			use entity work.registerfile(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_registerfile;

