void imprimir_datos(){

    Serial.print(t,3); Serial.print("\t");
    Serial.print(h,3); Serial.print("\t");

    Serial.print(t1,3); Serial.print("\t");
    Serial.print(h1,3);Serial.print("\t");

    Serial.print(t2,3);Serial.print("\t");
    Serial.print(h2,3);Serial.print("\t");
    Serial.print(p2,3);Serial.print("\t");

    Serial.print(adc0,6);Serial.print("\t"); 
    Serial.print(presionSF2,3);Serial.print("\t");
    Serial.print(presionCF21,3);Serial.print("\t"); //FiltroA1
    Serial.print(S21,3);Serial.print("\t"); //FiltroB1

    Serial.print(velocidadA,3);Serial.print("\t");  
    Serial.print(velocidadB,3);Serial.print("\t");

    Serial.print(tiempo);Serial.print("\t");

}
