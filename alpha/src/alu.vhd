library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        A       : in  STD_LOGIC_VECTOR (7 downto 0); -- first operand
        B       : in  STD_LOGIC_VECTOR (7 downto 0); -- second operand
        Opcode  : in  STD_LOGIC_VECTOR (3 downto 0); 
        Result  : out STD_LOGIC_VECTOR (7 downto 0); 
        -- flags : 
        Zero    : out STD_LOGIC;  
        Carry   : out STD_LOGIC;  
        Sign    : out STD_LOGIC   
    );
end ALU;

architecture Behavioral of ALU is
    
    signal temp_output : STD_LOGIC_VECTOR(7 downto 0);  -- Internal signal for Result
begin
    process(A, B, Opcode)	  
		variable  temp_result : STD_LOGIC_VECTOR(8 downto 0);  -- Internal variable for calculations 
		variable temp_var    : STD_LOGIC_VECTOR(7 downto 0); 
		
    begin 
		temp_result := (others => '0');
    	temp_var := (others => '0');
    	Carry <= '0';
	
        case Opcode is
            when "0000" =>  -- ADD
                temp_result := ('0' & A) + ('0' & B);
                temp_var := temp_result(7 downto 0);
                Carry  <= temp_result(8);

            when "0001" =>  -- SUB (A - B)
                temp_result := ('0' & A) - ('0' & B);
                temp_var := temp_result(7 downto 0);
                Carry  <= temp_result(8);

            when "0010" =>  -- XOR
                temp_var := A xor B;
                Carry  <= '0';

            when "0011" =>  -- AND
                temp_var := A and B;
                Carry  <= '0';

            when "0100" =>  -- SHL
                temp_var := A(6 downto 0) & '0';
                Carry  <= A(7);

            when "0101" =>  -- SHR 
                temp_var := '0' & A(7 downto 1);
                Carry  <= A(0);

            when "0110" =>  -- NOT
                temp_var := not A;
                Carry  <= '0';

            when "0111" =>  -- CMP
                temp_result := ('0' & A) - ('0' & B);  
                Carry <= temp_result(8);
                temp_var := (others => '0'); -- No meaningful result, just flags

            when "1000" =>  -- ADDI (A + Immediate)
                temp_result := ('0' & A) + ('0' & B);
                temp_var := temp_result(7 downto 0);
                Carry  <= temp_result(8);

            when "1001" =>  -- SUBI (A - Immediate)
                temp_result := ('0' & A) - ('0' & B);
                temp_var := temp_result(7 downto 0);
                Carry  <= temp_result(8);

            when others =>  -- INVALID INPUT
                temp_var := (others => '0');
                Carry  <= '0';
        end case;

        -- Zero flag (Now using temp_var instead of Result)
        if temp_var = "00000000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;

        -- Sign flag
        Sign <= temp_var(7);
		 -- temp_var process
    	temp_output <= temp_var;
    end process;			   
	 -- Assign temp_output to actual Result output
     Result <= temp_output;
end Behavioral;
