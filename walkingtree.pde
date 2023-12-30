float fish_x;
float fish_y;
float dir_x = 0;
float dir_y = 0;
float speed = 3;
float face_angle = 0;

ArrayList<tree> trees;
ArrayList<tree2> trees2;
int circle_num = 5;
int color_timer = 0;
int max_color_timer = 800;




void setup(){
  size(1200,800);
  background(255);
  trees = new ArrayList<tree>();
  trees2 = new ArrayList<tree2>();
  
  fish_x = width/2;
  fish_y = height/2;
  

  //trees.add(new tree(width/2,height/2,UNDER,0,true,2));
  reborn();
  
}

void draw(){
  //background(255,255,255,50);
  noStroke();
  fill(255,255,255,50);
  rect(0,0,width,height);

  

  direction(0.5);
  
  int pp = trees.size();
  for(int i=0;i<pp;i++){
    if(i<trees.size()){
    trees.get(i).show();
    trees.get(i).grow();
    }
  }
  pp = trees2.size();
  for(int i=0;i<pp;i++){
    if(i<trees2.size()){
    trees2.get(i).show();
    trees2.get(i).grow();
    }
  }
  
  boolean all_away = true;
  if(trees.isEmpty()==false){
    for(int i=0;i<trees.size();i++){
      if(trees.get(i).layer==1 && trees.get(i).nearfish()){all_away = false;break;}
    }
  }
  if(all_away){
    for(int i=0;i<trees.size();i++){
      trees.get(i).alive = false;
      if(trees.get(i).age==1){trees.get(i).age=0;}
    }
    for(int i=0;i<trees2.size();i++){
      trees2.get(i).alive = false;
      if(trees2.get(i).age==1){trees2.get(i).age=0;}
    }
    //trees.add(new tree(fish_x,fish_y,UNDER,0,true,2));
    reborn();
  }
  //saveFrame("frames/####.tif");
}

void direction(float new_ratio){
  //draw_rect();
  draw_fish(fish_x,fish_y,face_angle);
  
  float det_x = mouseX-fish_x;
  float det_y = mouseY-fish_y;
  float det = sqrt(det_x*det_x+det_y*det_y);
  if(det!=0){
    det_x = det_x*speed/det;
    det_y = det_y*speed/det;}
  float dir = sqrt(dir_x*dir_x+dir_y*dir_y);
  if(dir!=0){
    dir_x = dir_x*speed/dir;
    dir_y = dir_y*speed/dir;}
  dir_x = dir_x*(1-new_ratio) + det_x*new_ratio;
  dir_y = dir_y*(1-new_ratio) + det_y*new_ratio;
    
  if(det<=speed*10){
    if(det<=speed){
      dir_x = 0;
      dir_y = 0;}
    else{
      dir_x = dir_x*(det-speed)/speed/9;
      dir_y = dir_y*(det-speed)/speed/9;}
  }
  fish_x += dir_x;
  fish_y += dir_y;
  
  if(det_y>0){
    face_angle = atan(-det_x/det_y);
    face_angle += PI;
  }
  else{ 
    face_angle = atan(-det_x/det_y);
  }
  
  color_timer += sqrt(dir_x*dir_x+dir_y*dir_y);
  if(color_timer>max_color_timer){color_timer -= max_color_timer;}
}

//void draw_rect(){
//  noStroke();
//  fill(0);
//  pushMatrix();
//  translate(fish_x,fish_y);
//  rotate(face_angle);
//  rect(0,0,10,5);
//  popMatrix();
//}

void draw_fish(float cx,float cy,float angle_in){
  noStroke();
  fill(0,100);
  pushMatrix();
  translate(cx,cy);
  rotate(angle_in);
  ellipse(0,0,10,30);
  triangle(0,15,-8,23,8,23);
  popMatrix();
}

void reborn(){
  float ta = random(0,TAU/circle_num);
  for(int i=0;i<circle_num;i++){
    trees.add(new tree(fish_x,fish_y,UNDER,0,true,ta));
    trees2.add(new tree2(fish_x,fish_y,UNDER,0,true,ta,color_timer));
    ta += TAU/circle_num;
  }
}
