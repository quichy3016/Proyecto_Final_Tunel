void calculo_offset(){
    if (contador==10){
        offsett=t-tempref;
        offsett1=t1-tempref;
        offsett2=t2-tempref;
        offseth=h-humref;
        offseth1=h1-humref;
        offseth2=h2-humref;
        offsetp2=p2-presionref;
        cancelcontador=1;
        contador=0;
    }
    if (cancelcontador==0){
        contador=contador+1;
    }
}