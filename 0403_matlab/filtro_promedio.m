%[A]=importdata('DifP1.dat'); %%SHT31
A=[2;5;8;11;8;2;7;5];
n = length(A);
j= zeros(n,1);
A1=0;
%%j = float('single');
%%a=5.5

% for i=1:1:n
%     if i==1
%         j(i)=A(i);
%         A1=j(i);
%     else
%         j(i)=(A(i)+A1)/2;
%         A1=j(i);
%     end
%    
% end

m=3;
for i=1:1:n
    if i<m
        j(i)=A(i);
        A1=j(i); %% revisar
    else
        for k=1:1:m
             g=A(k)+A1;
             A1=g;
        end
        H(i)=g/n;
    end
end

