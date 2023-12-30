float grow_speed2 = 0.07;
float max_spread_angle2 = PI/4;
float branch2 = 16;
float ratio2 = 0.95;
float color_step = 20;

class tree2{
  float tx,ty;
  int type;
  int layer;
  float age;
  boolean alive;
  tree2 son1,son2;
  float grow_angle;
  boolean have_son;
  color tcolor;
  float index;
  
  
  tree2(float xin,float yin,int typein,int layer_father,boolean alivein,float angle,float color_index){
    tx = xin;
    ty = yin;
    type = typein;
    layer = layer_father+1;
    age = 0;
    alive = alivein;
    son1 = null;
    son2 = null;
    grow_angle = angle;
    have_son = false;
    index = color_index;
    tcolor = choose_color(color_index);
  }
  
  void grow(){
    if(alive){
    if(age<1-grow_speed2){
      age += grow_speed2;
    }else if(age<1){
      age = 1;
    }else if(age == 1 && son1 == null && layer<9){
      float tem = branch2*pow(ratio2,layer-1);
      float spread_angle = random(0,max_spread_angle2);
      float det_color = index+color_step*pow(ratio2,layer);
      trees2.add(new tree2(tx-tem*sin(grow_angle),ty+tem*cos(grow_angle),type,layer,alive,grow_angle+spread_angle,det_color));
      spread_angle = random(0,max_spread_angle2);
      trees2.add(new tree2(tx-tem*sin(grow_angle),ty+tem*cos(grow_angle),type,layer,alive,grow_angle-spread_angle,det_color));
      son1 = trees2.get(trees2.size()-2);
      son2 = trees2.get(trees2.size()-1);
      have_son = true;
    }
    }
    
    if(alive==false){
    if(age<1-grow_speed2){
      age += grow_speed2;
    }else if(age<1){
      age = 1;
    }else if(age == 1){
      if(have_son && son1.have_son == false){
        trees2.remove(son1);
        trees2.remove(son2);
        son1 = null;
        son2 = null;
        have_son =false;
      }
    if(layer==1 && have_son == false){
      trees2.remove(this);
    }
    }
    }
  }
  
  void show(){
    stroke(tcolor);
    strokeWeight(1.6);
    pushMatrix();
    translate(tx,ty);
    rotate(grow_angle);
    if(alive && age<1){
      float tem = branch2*pow(ratio2,layer-1)*age;
      line(0,0,0,tem);
    }
    else{
      float tem = branch2*pow(ratio2,layer-1);
      line(0,0,0,tem);
    }
    popMatrix();
  }
  
  
  boolean nearfish(){
    boolean result = false;
    if(dist(fish_x,fish_y,tx,ty)<=near_range){
      result = true;
    }
    return result;
  }
  
}
