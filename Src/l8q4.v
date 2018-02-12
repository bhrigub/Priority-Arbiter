module l8q4 (output gip1,gip2,gip3,gip4,input reqa,reqb,reqc,reqd,clk);

wire [3:0] req;
reg [3:0] grant,apri,bpri,cpri,dpri,t;

assign {gip1,gip2,gip3,gip4}=grant;
assign req={reqa,reqb,reqc,reqd};
	
initial
	begin
			apri=4;bpri=3;cpri=2;dpri=1;
	end
	
always @ (*)
begin
	if(gip1 == 1'b1)
		begin
			t = apri;
			apri = 1'b1;
			if (bpri < t)
				bpri = bpri+1'b1;
			if (cpri < t)
				cpri = cpri+1'b1;
			if (dpri < t)
				dpri = dpri+1'b1;
		end
		
	if(gip2 == 1'b1)
		begin
			t = bpri;
			bpri = 1'b1;
			if (apri < t)
				apri = apri+1'b1;
			if (cpri < t)
				cpri = cpri+1'b1;
			if (dpri < t)
				dpri = dpri+1'b1;
		end
		
	if(gip3 == 1'b1)
		begin
			t = cpri;
			cpri = 1'b1;
			if (apri < t)
				apri = apri+1'b1;
			if (bpri < t)
				bpri = bpri+1'b1;
			if (dpri < t)
				dpri = dpri+1'b1;	
		end
		
	if(gip4 == 1'b1)
		begin
			t = dpri;
			dpri = 1'b1;
			if (apri < t)
				apri = apri+1'b1;
			if (bpri < t)
				bpri = bpri+1'b1;
			if (cpri < t)
				cpri = cpri+1'b1;
		end
end
	
	always @(posedge clk)
	begin
	case (req)
	4'b0000:grant=4'b0;	
	4'b0001:grant=4'b0001;
	4'b0010:grant=4'b0010;
	4'b0011:
		begin
			if(cpri>dpri)
				grant=4'b0010;
			else
				grant=4'b0001;			
		end	
	4'b0100:grant=4'b0100;
	4'b0101:
		begin
			if(bpri>dpri)
				grant=4'b0100;
			else
				grant=4'b0001;
		end
	4'b0110:
		begin
			if(bpri>cpri)
				grant=4'b0100;
			else 
				grant=4'b0010;
		end	
	4'b0111:
		begin
			if(bpri>cpri&&bpri>dpri)
				grant=4'b0100;
			else if(cpri>bpri&&cpri>dpri)
				grant=4'b0010;
			else 
				grant=4'b0001;
		end	
	4'b1000:grant=4'b1000;
	4'b1001:
		begin
			if(apri>dpri)
				grant=4'b1000;
			else 
				grant=4'b0001;
		end	
	4'b1010:
		begin
			if(apri>cpri)
				grant=4'b1000;
			else 
				grant=4'b0010;
		end	
	4'b1011:
		begin
			if(apri>cpri&&apri>dpri)
				grant=4'b1000;
			else if(cpri>apri&&cpri>dpri)
				grant=4'b0010;
			else  
				grant=4'b0001;
		end		
	4'b1100:
		begin
			if(bpri>apri)
				grant=4'b0100;
			else
				grant=4'b1000;
		end
	4'b1101:
		begin
			if(bpri>apri&&bpri>dpri)
				grant=4'b0100;
			else if(apri>bpri&&apri>dpri)
				grant=4'b1000;
			else 
				grant=4'b0001;
		end		
	4'b1110:
		begin
			if(bpri>apri&&bpri>cpri)
				grant=4'b0100;
			else if(apri>bpri&&apri>cpri)
				grant=4'b1000;
			else 
				grant=4'b0010;
		end	
	4'b1111:
		begin
			if(bpri>apri&&bpri>cpri&&bpri>dpri)
				grant=4'b0100;
			else if(apri>bpri&&apri>cpri&&apri>dpri)
				grant=4'b1000;
			else if(cpri>bpri&&cpri>apri&&cpri>dpri)
				grant=4'b0010;
			else 
				grant=4'b0001;
		end
	endcase
	end	
always @ clk
	if(clk)
	$monitor ($time," Request A=%b Request B=%b Request C=%b Request D=%b Grant A=%b Grant B=%b Grant C=%b Grant D=%b ",reqa,reqb,reqc,reqd,gip1,gip2,gip3,gip4);
		else
	$monitor ();
	
endmodule	

//======================== TB ================================//
module tb;
wire tagrnt,tbgrnt,tcgrnt,tdgrnt;
reg treqa,treqb,treqc,treqd,tclk=0;
	
l8q4 t1 (tagrnt,tbgrnt,tcgrnt,tdgrnt,treqa,treqb,treqc,treqd,tclk);
	
always
	#5 tclk=~tclk;
	
initial
	begin
	treqa=1;treqb=1;treqc=1;treqd=1;
	#11	treqa=0;treqb=1;treqc=0;treqd=0;
	#11	treqa=1;treqb=1;treqc=1;treqd=1;
	#11	treqa=1;treqb=1;treqc=1;treqd=0;
	#11	treqa=1;treqb=1;treqc=0;treqd=0;
	#11	treqa=0;treqb=0;treqc=1;treqd=1;
	#11	treqa=0;treqb=0;treqc=1;treqd=0;
	#11	treqa=1;treqb=1;treqc=0;treqd=1;
	#11	treqa=1;treqb=0;treqc=1;treqd=0;
	#11	treqa=1;treqb=0;treqc=0;treqd=1;
	#11	treqa=1;treqb=0;treqc=0;treqd=0;
	#11	treqa=0;treqb=1;treqc=1;treqd=0;
	#11	treqa=0;treqb=1;treqc=0;treqd=1;
	#11	treqa=0;treqb=0;treqc=0;treqd=1;
	#11	treqa=0;treqb=0;treqc=0;treqd=0;
	#11	treqa=1;treqb=0;treqc=1;treqd=1;
	end
endmodule	