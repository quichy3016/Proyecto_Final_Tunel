%%Modificar
%carga los valores de prueba_8 y prueba_9 que son cuando las compuertas se
%abren y se cierran. no hay mucho para comparar porq ambas no fueron
%abiertas ni cerradas al mismo tiempo

m=900; %muestras
vel1=6;
vel2=7.5;
%% cargar valores
[P3]=table2array(readtable('Prueba_8.csv'));
[P4]=table2array(readtable('Prueba_9.csv'));


%% ArchivoP3
	% Prueba3
p3=	0.0699;
I3=	0.2035;
ca3=0;cb3=0;con3=0;
if (vel1==6 && vel2==7.5) || (vel1==7.5 && vel2==8.5)
    for i=1:size(P3)
        ref3= P3(i,15);
        if  ref3==vel1
            if ca3<m 
                v3=P3(i,11);
                ca3=ca3+1;
                con3=con3+1;
                K(con3,3)=v3;
                K(con3,2)=ref3;
                K(con3,1)=con3;            
            end
        end
        if  ref3==vel2
            if cb3<m 
                v3=P3(i,11);	
                cb3=cb3+1;
                con3=con3+1;
                K(con3,3)=v3;
                K(con3,2)=ref3;
                K(con3,1)=con3;
            end
        end
    end
end
if (vel1==8.5 && vel2==7.5) || (vel1==7.5 && vel2==7) || (vel1==7 && vel2==6)
    J3=find(P3(:,15)==8.5);
    for i=J3:size(P3)
        ref3= P3(i,15);
        if  ref3==vel1
            if ca3<m 
                v3=P3(i,11);
                ca3=ca3+1;
                con3=con3+1;
                K(con3,3)=v3;
                K(con3,2)=ref3;
                K(con3,1)=con3;            
            end
        end
        if  ref3==vel2
            if cb3<m 
                v3=P3(i,11);	
                cb3=cb3+1;
                con3=con3+1;
                K(con3,3)=v3;
                K(con3,2)=ref3;
                K(con3,1)=con3;
            end
        end
    end
end

%% ArchivoP4
	% Prueba4
p4=	0.244;
I4=	0.2756;
ca4=0;cb4=0;con4=0;
if (vel1==6 && vel2==7.5) || (vel1==7.5 && vel2==8.5)
    for i=1:size(P4)
        ref4= P4(i,15);
        if  ref4==vel1
            if ca4<m 
                v4=P4(i,11);
                ca4=ca4+1;
                con4=con4+1;
                K(con4,4)=v4;
            end
        end
        if  ref4==vel2
            if cb4<m 
                v4=P4(i,11);	
                cb4=cb4+1;
                con4=con4+1;
                K(con4,4)=v4;
            end
        end
    end
end
if (vel1==8.5 && vel2==7.5) || (vel1==7.5 && vel2==7) || (vel1==7 && vel2==6)
    J4=find(P4(:,15)==8.5);
    for i=J4:size(P4)
        ref4= P4(i,15);
        if  ref4==vel1
            if ca4<m 
                v4=P4(i,11);
                ca4=ca4+1;
                con4=con4+1;
                K(con4,4)=v4;
            end
        end
        if  ref4==vel2
            if cb4<m 
                v4=P4(i,11);	
                cb4=cb4+1;
                con4=con4+1;
                K(con4,4)=v4;
            end
        end
    end
end


%% Grafico

figure(1)
plot(K(:,1),K(:,2),'k',K(:,1),K(:,3),'b',K(:,1),K(:,4),'m');
txt3 = ['Prueba_3',' P= ',num2str(p3),' I= ',num2str(I3)];
txt4 = ['Prueba_4',' P= ',num2str(p4),' I= ',num2str(I4)];

text(200,8,txt3,'Color','b')
text(200,7.9,txt4,'Color','m')

