void calculo_offset(){
    if (contador==10){
        offsett=0;//t-tempref;
        offsett1=0;//t1-tempref;
        offsett2=0;//t2-tempref;
        offseth=0;//h-humref;
        offseth1=0;//h1-humref;
        offseth2=0;//h2-humref;
        offsetp2=p2-presionref;
        offsetdf=busvoltage;
        offsetdf1=adc0;
        cancelcontador=1;
        contador=0;
    }
    if (cancelcontador==0){
        contador=contador+1;
    }
}
