`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/15 15:21:45
// Design Name: 
// Module Name: PC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PC(Clk,Clrn,Result,Address);  
    
    input Clk;//ʱ��
    input Clrn;//�Ƿ����õ�ַ��0-��ʼ��PC����������µ�ַ       
    input[31:0] Result;
    output [31:0] Address;
    wire [31:0] pc_n;
    D_FFEC32 D_FFEC32_0(Result,Clk,1'b1,Clrn,Address,pc_n);
endmodule
