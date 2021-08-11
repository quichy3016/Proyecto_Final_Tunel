void cambio_automatico(){

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
 }else terminoautoma=0;

// Serial.print(Inref1);Serial.print(" ");
// Serial.print(vtiempoant);Serial.println(" ");


 
}
