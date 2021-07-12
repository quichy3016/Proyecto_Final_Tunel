%%Modificar
%cargo los valores tomados el día 7/7
%si la imagen sale con error es por la cantidad de muestras que es menor al tomado.
%vel1 y vel2 es para elegir el escalon a ver.
%cada color es un PID distinto
%los valores de las vel1 y vel2 pueden ser: 6- 7.5- 8.5- 7.5- 7- 6 en el
%orden correspondiente

m=600; %muestras
vel1=8.5;
vel2=7.5;
%% cargar valores
[P3]=table2array(readtable('Prueba_3.csv'));
[P4]=table2array(readtable('Prueba_4.csv'));
[P5]=table2array(readtable('Prueba_5.csv'));
[P6]=table2array(readtable('Prueba_6.csv'));
[P7]=table2array(readtable('Prueba_7.csv'));

%% ArchivoP3
	% Prueba3
% P=	0.0699
% I=	0.2035
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
% P=	0.244
% I=	0.2756
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

%% ArchivoP5
	% Prueba5
% P=	0.5451
% I=	0.3599
ca5=0;cb5=0;con5=0;
if (vel1==6 && vel2==7.5) || (vel1==7.5 && vel2==8.5)
    for i=1:size(P5)
        ref5= P5(i,15);
        if  ref5==vel1
            if ca5<m 
                v5=P5(i,11);
                ca5=ca5+1;
                con5=con5+1;
                K(con5,5)=v5;
            end
        end
        if  ref5==vel2
            if cb5<m 
                v5=P5(i,11);	
                cb5=cb5+1;
                con5=con5+1;
                K(con5,5)=v5;
            end
        end
    end
end
if (vel1==8.5 && vel2==7.5) || (vel1==7.5 && vel2==7) || (vel1==7 && vel2==6)
    J5=find(P5(:,15)==8.5);
    for i=J5:size(P5)
        ref5= P5(i,15);
        if  ref5==vel1
            if ca5<m 
                v5=P5(i,11);
                ca5=ca5+1;
                con5=con5+1;
                K(con5,5)=v5;
            end
        end
        if  ref5==vel2
            if cb5<m 
                v5=P5(i,11);	
                cb5=cb5+1;
                con5=con5+1;
                K(con5,5)=v5;
            end
        end
    end
end

%% ArchivoP6
	% Prueba6
% P=	0.6846
% I=	0.4183
ca6=0;cb6=0;con6=0;
if (vel1==6 && vel2==7.5) || (vel1==7.5 && vel2==8.5)
    for i=1:size(P6)
        ref6= P6(i,15);
        if  ref6==vel1
            if ca6<m 
                v6=P6(i,11);
                ca6=ca6+1;
                con6=con6+1;
                K(con6,6)=v6;
            end
        end
        if  ref6==vel2
            if cb6<m 
                v6=P6(i,11);	
                cb6=cb6+1;
                con6=con6+1;
                K(con6,6)=v6;
            end
        end
    end
end
if (vel1==8.5 && vel2==7.5) || (vel1==7.5 && vel2==7) || (vel1==7 && vel2==6)
    J6=find(P6(:,15)==8.5);
    for i=J6:size(P6)
        ref6= P6(i,15);
        if  ref6==vel1
            if ca6<m 
                v6=P6(i,11);
                ca6=ca6+1;
                con6=con6+1;
                K(con6,6)=v6;
            end
        end
        if  ref6==vel2
            if cb6<m 
                v6=P6(i,11);	
                cb6=cb6+1;
                con6=con6+1;
                K(con6,6)=v6;
            end
        end
    end
end
        
%% ArchivoP7
	% Prueba7
% P=	0.3286
% I=	0.3107
ca7=0;cb7=0;con7=0;
if (vel1==6 && vel2==7.5) || (vel1==7.5 && vel2==8.5)
    for i=1:size(P7)
        ref7= P7(i,15);
        if  ref7==vel1
            if ca7<m 
                v7=P7(i,11);
                ca7=ca7+1;
                con7=con7+1;
                K(con7,7)=v7;
            end
        end
        if  ref7==vel2
            if cb7<m 
                v7=P7(i,11);	
                cb7=cb7+1;
                con7=con7+1;
                K(con7,7)=v7;
            end
        end
    end
end
if (vel1==8.5 && vel2==7.5) || (vel1==7.5 && vel2==7) || (vel1==7 && vel2==6)
    J7=find(P7(:,15)==8.5);
    for i=J7:size(P7)
        ref7= P7(i,15);
        if  ref7==vel1
            if ca7<m 
                v7=P7(i,11);
                ca7=ca7+1;
                con7=con7+1;
                K(con7,7)=v7;
            end
        end
        if  ref7==vel2
            if cb7<m 
                v7=P7(i,11);	
                cb7=cb7+1;
                con7=con7+1;
                K(con7,7)=v7;
            end
        end
    end
end

%% Grafico
figure(1)
plot(K(:,1),K(:,2),'k',K(:,1),K(:,3),'b',K(:,1),K(:,4),'m',K(:,1),K(:,5),'c',K(:,1),K(:,6),'r',K(:,1),K(:,7),'g');
