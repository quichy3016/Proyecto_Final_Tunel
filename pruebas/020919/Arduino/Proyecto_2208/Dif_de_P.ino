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
  
  S11=(alpha1*presionSF)+((1-alpha1)*S11); //FiltroB
  S12=(alpha2*presionSF)+((1-alpha2)*S12);
  S13=(alpha3*presionSF)+((1-alpha3)*S13);
  
 ///////////ADS1115///////////////////////////
  adc0 = ads.readADC_SingleEnded(0)*4.096/32768;
  presionSF2 = (adc0 - offsetdf1) * (1000);
  ADCFilter1.Filter(presionSF2);
  ADCFilter2.Filter(presionSF2);
  ADCFilter3.Filter(presionSF2);
  presionCF21 =  ADCFilter1.Current();//FiltroA1
  presionCF22 =  ADCFilter2.Current();
  presionCF23 =  ADCFilter3.Current();
  
  S21=(alpha1*presionSF2)+((1-alpha1)*S21); //FiltroB1
  S22=(alpha2*presionSF2)+((1-alpha2)*S22);
  S23=(alpha3*presionSF2)+((1-alpha3)*S23);
  
}
