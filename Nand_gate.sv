`timescale 1ns/1ps

// interfacing 

interface nand_if ();
        logic a,b;
        logic y;
endinterface

//class tranaction 
class txn;
        rand bit a,b ;
        bit y;

        function void display (input string tag="");
                $display("[%s] %b %b |%b at time =%0t",tag,a,b,y,$time);
        endfunction
endclass

// generator 

class generator ;
        txn tr ;
        mailbox gen2drv;

        function new (mailbox mb);
                gen2drv=mb;
        endfunction

        task run();
                repeat(5) begin
                tr=new();

                assert (tr.randomize());
                gen2drv.put(tr);

                tr.display("Gen");
                end
        endtask
endclass

//driver 
class driver;
        txn tr;
        mailbox gen2drv;
        virtual nand_if vif;

        function new (virtual nand_if vif,mailbox mb);
                this.vif=vif;
                gen2drv=mb;
        endfunction

        task run ();
                tr=new();
                forever begin
                        gen2drv.get(tr);
                        vif.a=tr.a;
                        vif.b=tr.b;
                        vif.y=tr.y;
                        #5;
                end
        endtask
endclass

//monitor class
class monitor;
        txn tr;
        mailbox mon2scb;
        virtual nand_if vif;

        function new (virtual nand_if vif,mailbox mb);
                this.vif=vif;
                this.mon2scb=mb;
        endfunction

        task run();
                tr= new();
                forever begin
                        tr.a=vif.a;
                        tr.b=vif.b;
                        tr.y=vif.y;

                        mon2scb.put(tr);
                        tr.display("Mon");
                        #4;
                end
        endtask
endclass

//score board ;
class scoreboard ;
        txn tr ;
        mailbox mon2scb ;
        bit exp_y;

        function new(mailbox mb);
                mon2scb=mb;
        endfunction

        task run ();
                tr=new();
                forever begin
                        mon2scb.get(tr);
                        exp_y=~(tr.a & tr.b);

                if(exp_y==tr.y)
                        $display("Pass");
                else
                        $display("Fail");
                end
        endtask
endclass

//monitor

module  tb();
nand_if nand_3();
nand_3 u1(nand_3.a,nand_3.b,nand_3.y);
mailbox gen2drv=new();
mailbox mon2scb=new();

generator gen;
monitor mon ;
driver drv;
scoreboard scb;

initial begin
        $display("[] A B |Y");
        $display("          ");

        gen=new(gen2drv);
        drv=new(nand_3,gen2drv);
        mon=new(nand_3,mon2scb);
        scb=new(mon2scb);

        fork
                gen.run();
                drv.run();
                mon.run();
                scb.run();
        join_none
        #100;
        $finish ;
        end
endmodule

//rtl

`timescale 1ns/1ps

module nand_3 (a,b,y);
input a;
input b;
output y;

assign y = ~(a&b);

endmodule

//tb

`timescale 1ns/1ps

module tb ();

logic a,b;
logic  y;

nand_3 DUT (.a(a),.b(b),.y(y));

initial begin

        a = 0; b = 0; #5;
        a = 0; b = 1; #5;
        a = 1; b = 1; #5;
        a = 1; b = 0; #5;
        a = 1; b = 1; #5;
        a = 0; b = 1; #5;
        a = 1; b = 1; #5;

$finish;

end

initial begin

        $monitor ("time = %0t, a = %b, b = %b, y = %b", $time,a,b,y);

end
endmodule
