int ABOVE = 0;
int UNDER = 1;
float grow_speed = 0.06;//0.07
float near_range = 10*speed;
float max_spread_angle = PI/3;//4
float branch = 27;//16
float ratio = 0.8;//0.95
class tree{
  float tx,ty;
  int type;
  int layer;
  float age;
  boolean alive;
  tree son1,son2;
  float grow_angle;
  boolean have_son;
  
  
  tree(float xin,float yin,int typein,int layer_father,boolean alivein,float angle){
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
  }
  
  void grow(){
    if(alive){
    if(age<1-grow_speed){
      age += grow_speed;
    }else if(age<1){
      age = 1;
    }else if(age == 1 && son1 == null && layer<8){
      float tem = branch*pow(ratio,layer-1);
      float spread_angle = random(0,max_spread_angle);
      trees.add(new tree(tx-tem*sin(grow_angle),ty+tem*cos(grow_angle),type,layer,alive,grow_angle+spread_angle));
      spread_angle = random(0,max_spread_angle);
      trees.add(new tree(tx-tem*sin(grow_angle),ty+tem*cos(grow_angle),type,layer,alive,grow_angle-spread_angle));
      son1 = trees.get(trees.size()-2);
      son2 = trees.get(trees.size()-1);
      have_son = true;
    }
    }
    
    if(alive==false){
    if(age<1-grow_speed){
      age += grow_speed;
    }else if(age<1){
      age = 1;
    }else if(age == 1){
      if(have_son && son1.have_son == false){
        trees.remove(son1);
        trees.remove(son2);
        son1 = null;
        son2 = null;
        have_son =false;
      }
    if(layer==1 && have_son == false){
      trees.remove(this);
    }
    }
    }
  }
  
  void show(){
    stroke(20);
    strokeWeight(1);
    pushMatrix();
    translate(tx,ty);
    rotate(grow_angle);
    if(alive && age<1){
      float tem = branch*pow(ratio,layer-1)*age;
      line(0,0,0,tem);
    }
    else{
      float tem = branch*pow(ratio,layer-1);
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
