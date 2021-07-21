[ALL]=importdata('Corriente_7_putty.csv'); %%valor de muestras
[P]=importdata('nana.csv'); %%valor de muestras
%[A]=ALL(:,5);

[T]=ALL.data(:,11);
[B]=ALL.textdata(:,1);

%%[E]=cell2mat(B);

 for i = 1:length(B)
    B1(i,1) = str2num(cell2mat(B(i))); 
 end

 [C]=ALL.textdata(:,2);
 for i = 1:length(C)
    C1(i,1) = str2num(cell2mat(C(i))); 
 end
 
%  [D]=ALL.textdata(:,4);
%  for i = 1:length(D)
%     D1(i,1) = str2num(cell2mat(D(i))); 
%  end
% D1=D1/10;
% 
% [E]=ALL.textdata(:,5);
%  for i = 1:length(E)
%     E1(i,1) = str2num(cell2mat(E(i))); 
%  end
% E1=E1/100;
% 
% [F]=ALL.textdata(:,6);
%  for i = 1:length(F)
%     F1(i,1) = str2num(cell2mat(F(i))); 
%  end
% %F1=F1/100;
% 
% [G]=ALL.textdata(:,7);
%  for i = 1:length(G)
%     G1(i,1) = str2num(cell2mat(G(i))); 
%  end
%F1=F1/100;

[D]=ALL.data(:,1);
D=D/10;

[E]=ALL.data(:,2);
E=E/100;

[F]=ALL.data(:,3);
%F=F/100;

[G]=ALL.data(:,4);
%F=F/100;

[H]=ALL.data(:,5);
%F=F/100;

[I]=ALL.data(:,6);
%F=F/100;

[J]=ALL.data(:,7);
%F=F/100;

[K]=ALL.data(:,8);
%F=F/100;

[L]=ALL.data(:,8);
%F=F/100;

[M]=ALL.data(:,9);
%F=F/100;

[N]=ALL.data(:,10);
%F=F/100;

[O]=ALL.data(:,12);
%F=F/100;

[P]=ALL.data(:,13);
%F=F/100;


plot(T,P);

ylim([0 2]);



[ALL1]=[B1,C1,P,D,E,F,G,H,I,J,K,L,M,N,O];

csvwrite('Corriente7_matlab.csv',ALL1);