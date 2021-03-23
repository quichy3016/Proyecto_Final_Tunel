void difPresion(){
  
 ///////////ADS1115///////////////////////////
  adc0 = ads.readADC_SingleEnded(0)*4.096/32768;
  presionSF2 = (adc0 - offsetdf1) * (1000);
  ADCFilter1.Filter(presionSF2);
  presionCF21 =  ADCFilter1.Current();//FiltroA1
  
  S21=(alpha1*presionSF2)+((1-alpha1)*S21); //FiltroB1

  ADCFilterM = medianFilter.AddValue(presionSF2);
  
}
