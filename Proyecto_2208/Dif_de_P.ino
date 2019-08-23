void difPresion(){
    /////////INA-219////////////////////////
  float busvoltage = ina219.getBusVoltage_V();
  presionSF = (busvoltage - 2.524) * (1000);
  ADCFilter0.Filter(presionSF); //FiltroA
  presionCF = ADCFilter0.Current();
  Serial.print(busvoltage,3);Serial.print("\t"); 
  Serial.print(presionSF,3);Serial.print("\t");
  Serial.print(presionCF,3);Serial.print("\t"); //FiltroA
  S=(alpha*presionSF)+((1-alpha)*S); //FiltroB
  Serial.print(S,3);Serial.print("\t"); //FiltroB
 ///////////ADS1115///////////////////////////
  float adc0 = ads.readADC_SingleEnded(0)*4.096/32768;
  presionSF2 = (adc0 - 2.52) * (1000);
  ADCFilter1.Filter(presionSF2);
  presionCF2 =  ADCFilter1.Current();//FiltroA1
  Serial.print(adc0,6);Serial.print("\t"); 
  Serial.print(presionSF2,3);Serial.print("\t");
  Serial.print(presionCF2,3);Serial.print("\t"); //FiltroA1
  S1=(alpha*presionSF2)+((1-alpha)*S1); //FiltroB1
  Serial.print(S1,3);Serial.print("\t"); //FiltroB1
}
