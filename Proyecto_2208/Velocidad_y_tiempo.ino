void vel_tiempo(){
    //////////Calculo velocidad////////////////
  velocidadA = sqrt((2*abs(presionCF))/1.183);
  velocidadB = sqrt(2*abs(S)/1.183);
  Serial.print(velocidadA,3);Serial.print("\t");  
  Serial.print(velocidadB,3);Serial.print("\t");

  velocidadA1 = sqrt((2*abs(presionCF2))/1.183);
  velocidadB1 = sqrt(2*abs(S1)/1.183);
  Serial.print(velocidadA1,3);Serial.print("\t");  
  Serial.print(velocidadB1,3);Serial.print("\t"); 
  
  /////////////////////////////////////////
  tiempo=millis();
  Serial.print(tiempo);Serial.print("\t");
}
