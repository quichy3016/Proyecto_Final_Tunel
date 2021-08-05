name= "thrshtrdhtyh.csv";
[ALL]=table2array(readtable(name));

[AA]=ALL(:,1);%muestras
[A]=ALL(:,2); 
[B]=ALL(:,3); 
[C]=ALL(:,4); 
[D]=ALL(:,5); 
[E]=ALL(:,6); 
[F]=ALL(:,7); 
[G]=ALL(:,8); 
[H]=ALL(:,9); 
[I]=ALL(:,10); 
[J]=ALL(:,11); 
[K]=ALL(:,12);
%%%%%%%%%%%%%%%%%%K=K/1000;
[L]=ALL(:,13); 
[M]=ALL(:,14); 
[T]=ALL(:,15); 
%[O]=ALL(:,16); 


figure(1)
plot(A,H,'k',A,C,'b');%v c/f. + v ref
%%xlim([0 50]);  %%ver si puedo ingresar por aca el tiempo
title("PUEDO AGREGARLO?");
xlabel('xlabel [x]') 
ylabel('ylabel [y]') 
legend({'ref 1','ref2'},'Location','northwest')