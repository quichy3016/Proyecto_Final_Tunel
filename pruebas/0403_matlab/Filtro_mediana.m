[A]=importdata('VelADC.dat'); 
%A =[5 15 80 4 3 65 21 32 45];
[A2]=importdata('VelADCb2.dat'); 
[T]=importdata('Tiempo.dat'); 
[M]=importdata('Valoresmuestras.dat'); 
T=T/1000;
A=-A;
% for i=1:1:(N-m)
%     T1(i)=T(i+m);
% end
% T1(N-m+1)=T(N);


N = length(A);
m=25;

for i=1:1:N
    if i<m
    else        
        for j=1:1:m
        B(j)=A(j+i-m);
        end
        D(i)=median(B);
        %B(i)=0;
    end  
end

for i=1:1:N
    if i<m
    else        
        for j=1:1:m
        B(j)=A(j+i-m);
        end
        F(i)=mean(B);
        %B(i)=0;
    end
    
end
plot(T,A,'r-o',T,D,'g-x',T,F,'b-o')