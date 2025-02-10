library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is		
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC_VECTOR(7 downto 0);
	signal B : STD_LOGIC_VECTOR(7 downto 0);
	signal Opcode : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Result : STD_LOGIC_VECTOR(7 downto 0);
	signal Zero : STD_LOGIC;
	signal Carry : STD_LOGIC;
	signal Sign : STD_LOGIC;

	-- Component declaration of the tested unit
	component alu
	port(
		A : in STD_LOGIC_VECTOR(7 downto 0);
		B : in STD_LOGIC_VECTOR(7 downto 0);
		Opcode : in STD_LOGIC_VECTOR(3 downto 0);
		Result : out STD_LOGIC_VECTOR(7 downto 0);
		Zero : out STD_LOGIC;
		Carry : out STD_LOGIC;
		Sign : out STD_LOGIC );
	end component;

	
	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		port map (
			A => A,
			B => B,
			Opcode => Opcode,
			Result => Result,
			Zero => Zero,
			Carry => Carry,
			Sign => Sign
		);

	-- Add your stimulus here ...	 
	process
    begin

        -- ??? ?????? ADD (0000)
        A <= "00000101"; -- 5
        B <= "00000011"; -- 3
        Opcode <= "0000";  -- ADD
        wait for 10 ns; 
		
		-- ??? ?????? SUB (0001)

        Opcode <= "0001";  -- SUB
        wait for 10 ns;

        -- ??? ?????? XOR (0010)

        Opcode <= "0010";  -- XOR
        wait for 10 ns;

        -- ??? ?????? AND (0011)

        Opcode <= "0011";  -- AND
        wait for 10 ns;

        -- ??? ?????? SHL (0100)

        Opcode <= "0100";  -- SHL
        wait for 10 ns;

        -- ??? ?????? SHR (0101)
        Opcode <= "0101";  -- SHR
        wait for 10 ns;

        -- ??? ?????? NOT (0110)
        A <= "00001100"; -- 12
        Opcode <= "0110";  -- NOT
        wait for 10 ns;

        -- ??? ?????? CMP (0111)

        Opcode <= "0111";  -- CMP (???? Zero=1 ????)
        wait for 10 ns;

        -- ??? ?????? ADDI (1000)
        B <= "00000011"; -- ????? ???? (Immediate = 3)
        Opcode <= "1000";  -- ADDI
        wait for 10 ns;

        -- ??? ?????? SUBI (1001)
        B <= "00000010"; -- ????? ???? (Immediate = 2)
        Opcode <= "1001";  -- SUBI
        wait for 10 ns;

        -- ????? ???
       
        wait;
    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alu;

