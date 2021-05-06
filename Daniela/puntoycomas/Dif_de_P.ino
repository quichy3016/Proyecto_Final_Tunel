void difPresion(){
  
 ///////////ADS1115///////////////////////////
  adc0 = ads.readADC_SingleEnded(0)*4.096/32768;
  //adc0 = (ads.readADC_SingleEnded(0)*0.125);
  presionSF2 = (adc0 -offsetdf1-offsetp2)*1000;   ////Presion en PA   res MPX70002dp= 1kPa/V
  //presionSF2 = (adc0 - 19003);
  ADCFilter1.Filter(presionSF2);
  presionCF21 =  ADCFilter1.Current();//FiltroA1
  
  S21=(alpha1*presionSF2)+((1-alpha1)*S21); //FiltroB1

  ADCFilterM = medianFilter.AddValue(presionSF2);
  
}
