void imprimir_datos(){

   // Serial.print(t,3); Serial.print("\t");
   // Serial.print(h,3); Serial.print("\t");

    //Serial.print(t1,3); Serial.print("\t");
    //Serial.print(h1,3);Serial.print("\t");

    Serial.print(t2,3);Serial.print(" ");
    Serial.print(h2,3);Serial.print(" ");
    Serial.print(p2,3);Serial.print(" ");

    Serial.print(adc0,6);Serial.print(" "); 
    Serial.print(presionSF2,3);Serial.print(" ");
    Serial.print(presionCF21,3);Serial.print(" "); //FiltroA1
    Serial.print(S21,3);Serial.print(" "); //FiltroB1

    Serial.print(velocidadA,3);Serial.print(" ");  
    Serial.print(velocidadB,3);Serial.print(" ");

    Serial.print(tiempo);Serial.print(" ");//\t
    Serial.print(pw);Serial.print(" ");

}
