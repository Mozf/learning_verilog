Fs = 10000; %����Ƶ��
N = 4096; %��������
N1 = 0 : 1/Fs : N/Fs-1/Fs;

s = sin(1000*2*pi*N1) + sin(3000*2*pi*N1) + sin(4000*2*pi*N1);%�������Ҳ�
maxs = max(s);
mins = min(s);
fidc = fopen('mem.txt','w');
for x = 1 : N
 fprintf(fidc,'%x\n',round((s(x)*120));
end
fclose(fidc);