void calculo_offset() {
  if (contador < 35) {
    offsett = 0; 
    offsett1 = 0; 
    offsett2 = 0; 
    offseth = 0; 
    offseth1 = 0; 
    offseth2 = 0;
    offsetdf = meanFilter.AddValue(adc0 - offsetdf1);
    contador = contador + 1;
  }
  else {
    if (contador == 35) {
      offsetp2 = offsetdf;
    }
    contador = contador + 1;
  }

}
