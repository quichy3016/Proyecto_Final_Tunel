void cambio_automatico(){

  if (cambio1==0){
    Encendido = 1;   //Habilito Ai1
    RUNSTOP = 1;     //Doy Marcha
    cambio1 = 1;
  }

  

  int len=sizeof(entrada1);
  len=len/2;
  if  (inc1<=len-1){
    
  
 if (cambio==1){
  
    Inref1=entrada1[inc];
    vtiempoant=millis();  
    cambio=0;
   
 }


 

 if ((millis()-vtiempoant)>=entrada1[inc1]){
  inc = inc+2;
  inc1 = inc1+2;
  cambio=1;
 }
 }else {
        RUNSTOP = 0;     //Apago Motor
        Encendido = 0;   //Deshabilito Ai1
        terminoautoma=0;     
       }

// Serial.print(Inref1);Serial.print(" ");
// Serial.print(vtiempoant);Serial.println(" ");


 
}
