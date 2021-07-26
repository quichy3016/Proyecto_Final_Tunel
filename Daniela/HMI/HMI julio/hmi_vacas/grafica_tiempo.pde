void grafica_tiempo (){
 // Prepare the points for the plot
  int nPoints = 1000;
  GPointsArray points = new GPointsArray(nPoints);

  for (int i = 0; i < nPoints; i++) {
    float x = 10 + random(200);
    float y = 10*exp(0.015*x);
    float xErr = 2*((float) r.nextGaussian());
    float yErr = 2*((float) r.nextGaussian());
    points.add(x + xErr, y + yErr);
  }

  plot1 = new GPlot(this);
  plot1.setPos(0.05*ancho, 0.05*alto);
  plot1.setDim(0.4*ancho, 0.3*alto);
  // Set the plot title and the axis labels
  plot1.setTitleText("Exponential law");
  plot1.getXAxis().setAxisLabelText("x");
  plot1.getYAxis().setAxisLabelText("y");
  plot1.setPoints(points);
  plot1.setPointColor(color(100, 100, 255, 50));     
  
  plot2 = new GPlot(this);
  plot2.setPos(0.05*ancho, 0.52*alto);
  plot2.setDim(0.4*ancho, 0.3*alto);
  
  plot2.setTitleText("velocidad");
  //plot2.getXAxis().setAxisLabelText("x");
  //plot2.getYAxis().setAxisLabelText("y");
  plot2.setPoints(points);
  plot2.setPointColor(color(0, 100, 255, 50)); 
}
