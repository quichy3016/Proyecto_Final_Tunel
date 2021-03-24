void escalon(){
  
  if (tiempo>=5000 & tiempo<=10000 & pw<=200) {
      pw=pw+3;
    }
  
  if (tiempo>=10000 & tiempo<=15000) {
      pw=200;
    }
    if (tiempo>=15000) {
      pw=600;
    }

   
  }
