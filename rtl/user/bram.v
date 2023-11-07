module bram(
    CLK,
    RST,
    WE0,
    EN0,
    Di0,
    Do0,
    READY,
    A0
);

    input   wire            CLK;
    input   wire 	     RST;
    input   wire    [3:0]   WE0;
    input   wire            EN0;
    input   wire    [31:0]  Di0;
    output  reg     [31:0]  Do0;
    output  reg	     READY;
    input   wire    [31:0]   A0;

    integer i;
    reg [31:0] count;
    // 16 kB
    parameter N =10;
    (* ram_style = "block" *) reg [31:0] RAM[0:2**N-1];
    
    always @(posedge CLK) begin // delay 10 cycle
    	if (RST) begin
    		count <= 32'b0;
    		READY <= 1'b0;
    	end
    	else begin
    	        READY <= 0;
    		if (EN0) begin
    			if(count<11)begin
	    			count <= count + 1;
	    			READY <= 1'b0;
	    		end
	    		else begin
	    			count <= 32'b0;
	    			READY <= 1'b1;
	    		end
    		end
        end
    end

    always @(posedge CLK) begin // tap memory
    	if (RST) begin
    		for(i=0; i<2**N-1; i = i+1) begin
    			RAM[i] <= 0;
    		end
    	end
        else if(EN0) begin
            Do0 <= RAM[A0[N-1:0]];
            if(WE0[0]) RAM[A0[N-1:0]][7:0] <= Di0[7:0];
            if(WE0[1]) RAM[A0[N-1:0]][15:8] <= Di0[15:8];
            if(WE0[2]) RAM[A0[N-1:0]][23:16] <= Di0[23:16];
            if(WE0[3]) RAM[A0[N-1:0]][31:24] <= Di0[31:24];
        end
        else begin
            Do0 <= 32'b0;
        end
   end
endmodule
