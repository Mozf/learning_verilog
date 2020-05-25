Fs = 10000; 
N = 4096; 
N1 = 0 : 1/Fs :N/Fs-1/Fs;

in =sin(1000*2*pi*N1) + sin(3000*2*pi*N1) + sin(4000*2*pi*N1);
coeff =[-0.0406,-0.0017,0.1785,0.3767,0.3767,0.1785,-0.0017,-0.0406];
out =conv(in,coeff);%����˲�
subplot(2,1,1);
plot(in);
xlabel('�˲�ǰ');
axis([0 200 -3 3]);
subplot(2,1,2);
plot(out);
xlabel('�˲���');
axis([100 200 -2 2]);