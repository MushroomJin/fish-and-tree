color c1 = color(90,191,64);
color c2 = color(68,136,242);
color c3 = color(242,127,68);
color c4 = color(158,214,224);

color choose_color(float x){
  color result;
  float y = map(x,0,max_color_timer,0,4);
  if(y<1){result = mixure(c1,c2,y);
  }else if(y<2){result = mixure(c2,c3,y-1);
  }else if(y<3){result = mixure(c3,c4,y-2);
  }else{result = mixure(c4,c1,y-3);
  }
  return result;
}

color mixure(color co1,color co2,float s){
  float r = red(co1)  *(1-s) +   red(co2)*s;
  float g = green(co1)*(1-s) + green(co2)*s;
  float b = blue(co1) *(1-s) +  blue(co2)*s;
  return color(r,g,b,160);
}
