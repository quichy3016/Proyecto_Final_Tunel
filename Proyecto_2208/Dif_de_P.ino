void difPresion(){
    /////////INA-219////////////////////////
  busvoltage = ina219.getBusVoltage_V();
  presionSF = (busvoltage - offsetdf) * (1000);
  INAFilter1.Filter(presionSF); //FiltroA
  INAFilter2.Filter(presionSF);
  INAFilter3.Filter(presionSF);
  presionCF1 = INAFilter1.Current();
  presionCF2 = INAFilter2.Current();
  presionCF3 = INAFilter3.Current();
  Serial.print(busvoltage,3);Serial.print("\t"); 
  Serial.print(presionSF,3);Serial.print("\t");
  Serial.print(presionCF1,3);Serial.print("\t"); //FiltroA
  Serial.print(presionCF2,3);Serial.print("\t");
  Serial.print(presionCF3,3);Serial.print("\t");
  S11=(alpha1*presionSF)+((1-alpha1)*S11); //FiltroB
  S12=(alpha2*presionSF)+((1-alpha2)*S12);
  S13=(alpha3*presionSF)+((1-alpha3)*S13);
  Serial.print(S11,3);Serial.print("\t"); //FiltroB
  Serial.print(S12,3);Serial.print("\t");
  Serial.print(S13,3);Serial.print("\t");
 ///////////ADS1115///////////////////////////
  adc0 = ads.readADC_SingleEnded(0)*4.096/32768;
  presionSF2 = (adc0 - offsetdf1) * (1000);
  ADCFilter1.Filter(presionSF2);
  ADCFilter2.Filter(presionSF2);
  ADCFilter3.Filter(presionSF2);
  presionCF21 =  ADCFilter1.Current();//FiltroA1
  presionCF22 =  ADCFilter2.Current();
  presionCF23 =  ADCFilter3.Current();
  Serial.print(adc0,6);Serial.print("\t"); 
  Serial.print(presionSF2,3);Serial.print("\t");
  Serial.print(presionCF21,3);Serial.print("\t"); //FiltroA1
  Serial.print(presionCF22,3);Serial.print("\t");
  Serial.print(presionCF23,3);Serial.print("\t");
  S21=(alpha1*presionSF2)+((1-alpha1)*S21); //FiltroB1
  S22=(alpha2*presionSF2)+((1-alpha2)*S22);
  S23=(alpha3*presionSF2)+((1-alpha3)*S23);
  Serial.print(S21,3);Serial.print("\t"); //FiltroB1
  Serial.print(S22,3);Serial.print("\t");
  Serial.print(S23,3);Serial.print("\t");
}
