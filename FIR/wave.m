Fs = 10000; %采样频率
N = 4096; %采样点数
N1 = 0 : 1/Fs : N/Fs-1/Fs;

s = sin(1000*2*pi*N1) + sin(3000*2*pi*N1) + sin(4000*2*pi*N1);%三种正弦波
maxs = max(s);
mins = min(s);
fidc = fopen('mem.txt','w');
for x = 1 : N
 fprintf(fidc,'%x\n',round((s(x)*120));
end
fclose(fidc);