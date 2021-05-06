void calculo_offset(){
    if (contador<35){
        offsett=0;//t-tempref;
        offsett1=0;//t1-tempref;
        offsett2=0;//t2-tempref;
        offseth=0;//h-humref;
        offseth1=0;//h1-humref;
        offseth2=0;//h2-humref;
        //offsetp2=0;//p2-presionref;
        //offsetdf=0;//busvoltage;
        //offsetdf1 = meanFilter.AddValue(adc0);
        offsetdf=meanFilter.AddValue(adc0 -offsetdf1);
        //cancelcontador=1;
        contador=contador+1;
    }
    else {
        if (contador==35){
          offsetp2=offsetdf;}
      contador=contador+1;}
    //if (cancelcontador==0){
    //    contador=contador+1;
    //}
    //contador=contador+1;
}
