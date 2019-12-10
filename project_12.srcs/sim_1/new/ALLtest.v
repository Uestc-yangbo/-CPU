`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/14 17:40:35
// Design Name: 
// Module Name: TEST1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - Fsile Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ALLtest();
    reg Clk,Clrn;
    wire [31:0] Inst,NEXTADDR,Qb,Qa,InstAddr,D;
    
    wire [31:0]PCadd4,EXTIMM,InstL2,EXTIMML2,X,Y,Dout,I_Addr,
    R,D0,Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,
    Q16,Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0;
    wire Z,Regrt,Se,Wreg,Aluqa,Aluqb,Reg2reg,Cout,Wmem,Jal;
    wire [3:0]Aluc;
    wire [1:0]Pcsrc;
    wire [4:0]Wr,Wr0;
    //��ָ����зֽ����ر���
    wire [4:0]rs,rt,rd,sa;
    wire [5:0]op,func;
    wire [15:0]immediate;
    wire [25:0]address;
    assign op=Inst[31:26];
    assign func=Inst[5:0];
    assign rs=Inst[25:21];
    assign rt=Inst[20:16];
    assign rd=Inst[15:11];
    assign sa=Inst[10:6];
    assign immediate=Inst[15:0];
    assign address=Inst[25:0];
    initial begin 
        Clk=0;
        Clrn=0;
        #20
        Clrn<=1;
    end
    always #20 Clk=~Clk;
    
    //InstAddrΪPC�Ĵ���������ָ���ַ
    PC PC_0(Clk,Clrn,NEXTADDR,InstAddr);
    //PCadd4Ϊָ���ַ+4��ĵ�ַ
    PCadd4 PCadd4_0(InstAddr,PCadd4);
    //ָ��洢����InstΪ����ָ���ַ�����ָ��
    INSTMEM INSTMEM_0(InstAddr,Inst);
    //����ģ�� CONUNIT(Op,Func,Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,Jal)
    CONUNIT CONUNIT_0(op,func,Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,Jal);
    //MUX2X5(A0,A1,S,Y),����R��ָ�I��ָ��ѡ��Wr�������
    MUX2X5 MUX2X5_1(rd,rt,Regrt,Wr0);
    //����jalָ��ѡ��31�żĴ�����ָ���ַд��
    MUX2X5 MUX2X5_2(Wr0,31,Jal,Wr);
    //EXT16T32(X,Se,Y) �����źŶ���������������չ�ͷ�����չ
    EXT16T32 EXT16T32_0(immediate,Se,EXTIMM);
    //����J��ָ�ʵ��ָ���ַ��ƴ��,InstL2Ϊָ��j��ת��ĵ�ַ
    SHIFTER_COMBINATION SHIFTER_COMBINATION_0(address,PCadd4,InstL2);
    //����չ���������������λ
    SHIFTER32_L2 SHIFTER32_L2_0(EXTIMM,EXTIMML2);
    //�Ĵ����ѣ�������������мĴ�����ֵ
    REGFILE REGFILE_0(rs,rt,D,Wr,Wreg,Clk,Clrn,Qa,Qb,
    Q31,Q30,Q29,Q28,Q27,Q26,Q25,Q24,Q23,Q22,Q21,Q20,Q19,Q18,Q17,Q16,
    Q15,Q14,Q13,Q12,Q11,Q10,Q9,Q8,Q7,Q6,Q5,Q4,Q3,Q2,Q1,Q0);
    //����R��ָ���I��ָ���ALU�������XS����ѡ��
    MUX2X32 MUX2X32_1(EXTIMM,Qb,Aluqb,Y);
    //����R��ָ���I��ָ���ALU�������X����ѡ��
    MUX2X32 MUX2X32_2(Qa,Inst,Aluqa,X);
    //�߼���Ԫ
    ALU ALU_0(X,Y,Aluc,R,Z);
    //���ݴ洢��Ԫ
    DATAMEM DATAMEM_0(R,Qb,Clk,Wmem,Dout); 
    //ѡ��д���
    MUX2X32 MUX2X32_3(Dout,R,Reg2reg,D0);
    //����Jalָ��,ѡ��д��PCADD4��ֵ
    MUX2X32 MUX2X32_4(D0,PCadd4,Jal,D);
    //I��ָ���������ָ֧����ת��ַ
    CLA_32 CLA_32_0(PCadd4,EXTIMML2,0,I_Addr,Cout);
    //����һ�����ڵ�ָ���ַ����ѡ��
    MUX4X32 MUX4X32_0(PCadd4,I_Addr,Qa,InstL2,Pcsrc,NEXTADDR);
endmodule
