void vel_tiempo(){
    //////////Calculo velocidad////////////////
  velocidadB = sqrt((2*abs(presionCF22))/1.183);
  velocidadA = sqrt(2*abs(presionSF2)/1.183);
  Serial.print(velocidadA,3);Serial.print("\t");  
  Serial.print(velocidadB,3);Serial.print("\t");

  /////////////////////////////////////////
  tiempo=millis();
  Serial.print(tiempo);Serial.print("\t");
}
