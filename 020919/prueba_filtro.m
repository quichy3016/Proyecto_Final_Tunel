function prueba_filtro
F=csvread('prueba 2 con promedio.csv');
G=F(:,21);
M=1:length(G);
window=100;

prom=movmedian(G,window);
C = smoothdata(G,'gaussian',100);%no sirve es muy lento
plot(M,G,'k',M,prom,'r');%,M,C,'g')%negro sin filtro. r movedian. g smoothd

