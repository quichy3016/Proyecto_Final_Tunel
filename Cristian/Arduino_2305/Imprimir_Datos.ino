void imprimir_datos() {

  Serial.print(t1, 3); Serial.print(";");
  Serial.print(h1, 3); Serial.print(";");

  Serial.print(p2, 3); Serial.print(";");
  Serial.print(den, 4); Serial.print(";");

  Serial.print(adc0, 5); Serial.print(";");
  Serial.print(presionSF2, 3); Serial.print(";");
  Serial.print(presionCF21, 3); Serial.print(";"); //FiltroA1
  Serial.print(S21, 3); Serial.print(";"); //FiltroB1
  Serial.print(ADCFilterM, 3); Serial.print(";"); //Filtro Mediana

  Serial.print(velocidadA, 3); Serial.print(";");
  Serial.print(velocidadB, 3); Serial.print(";");
  Serial.print(velocidadC, 3); Serial.print(";");
  Serial.print(velocidadD, 3); Serial.print(";");

  Serial.print(tiempo); Serial.print(";"); //
  Serial.print(pw); Serial.print(";");
  Serial.print(BOT2); Serial.print(";");
  Serial.print(h2, 3); Serial.print(";");
  Serial.print(In); Serial.print(";");
  Serial.print(Error1); Serial.println(";");

}
