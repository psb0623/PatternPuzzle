PFont exfont;
PFont no;

import android.app.Activity;
import android.content.Context;
import android.os.Vibrator;
 
Activity act;
int gamemode=0;
int st=1;
int size=3;
int h, n, i, j;
float r=1;
int cnt=0;
int current=-1; 
int count=0; 
int prob_num=0; 
float a, b, c;

int[] x = new int[9];   
int[] y = new int[9];   
int[] ansx = new int[9];
int[] ansy = new int[9];

int[] route={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
int[] used={0,0,0,0,0,0,0,0,0};
int[] effect={0,0,0,0,0,0,0,0,0};
boolean[] solved = new boolean[30]; 
int start;
float res, restime;

int[][] cnct = new int[9][9];
int[][] tmp = new int[9][9];
int[][][] ans = {
  {{0,1,0,0,0,0,0,0,0}, //1
  {1,0,1,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0}},
  
  {{0,1,0,0,0,0,0,0,0}, //2
  {1,0,1,0,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,1,0,0,0,1,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0}},
  
  {{0,1,0,0,0,0,0,0,0},  //3
  {1,0,1,0,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,1,0,0,0,1,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,0,0,1,0,1},
  {0,0,0,0,0,0,0,1,0}},
  
  {{0,1,0,1,0,0,0,0,0},  //4
  {1,0,1,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,0,0},
  {1,0,0,0,0,0,1,0,0},
  {0,0,0,0,0,1,0,0,0},
  {0,0,0,0,1,0,0,0,1},
  {0,0,0,1,0,0,0,1,0},
  {0,0,0,0,0,0,1,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,1,0,1,0,0,0,0,0},  //5
  {1,0,1,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,0,0},
  {1,0,0,0,1,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,0,0,1,0,0,0,1},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,0,0,1,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,1,0,0,0,0,0,0,0},  //6
  {1,0,0,0,1,0,0,0,0},
  {0,0,0,0,0,1,0,0,0},
  {0,0,0,0,1,0,1,0,0},
  {0,1,0,1,0,0,0,0,0},
  {0,0,1,0,0,0,0,0,1},
  {0,0,0,1,0,0,0,1,0},
  {0,0,0,0,0,0,1,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,1,0,0,0,0,0,0,0},  //7
  {1,0,1,0,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,0,0,0,1,0,0,0,1},
  {0,0,1,1,0,1,1,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,0,0,1,0,1},
  {0,0,0,1,0,0,0,1,0}},
  
  {{0,1,0,0,1,0,0,0,0},  //8
  {1,0,0,0,0,0,0,0,0},
  {0,0,0,0,1,1,0,0,0},
  {0,0,0,0,0,0,1,0,0},
  {1,0,1,0,0,0,0,0,0},
  {0,0,1,0,0,0,0,0,1},
  {0,0,0,1,0,0,0,1,0},
  {0,0,0,0,0,0,1,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,1,0,0,1,0,0,0,0},  //9
  {1,0,1,1,0,0,0,0,0},
  {0,1,0,0,0,0,0,0,0},
  {0,1,0,0,0,0,0,1,0},
  {1,0,0,0,0,1,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,0,0,0,0,0,0,0}},
  
  {{0,1,0,0,0,1,0,0,0},  //10
  {1,0,1,1,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,1,0,0,0,0,0,1,0},
  {0,0,1,0,0,0,1,0,0},
  {1,0,0,0,0,0,0,1,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,1,0,1,1,0,1},
  {0,0,0,0,0,0,0,1,0}},
  
  {{0,1,0,0,0,0,0,0,0},  //11
  {1,0,1,0,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,1,1,0,1,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,0,1,1,0,1},
  {0,0,0,0,0,0,0,1,0}},
  
  {{0,1,0,0,0,0,0,0,0},  //12
  {1,0,1,1,0,1,0,0,0},
  {0,1,0,0,0,1,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,0,0,1,0,0,0,0,0},
  {0,1,1,0,0,0,0,1,1},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,0,1,1,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,1,0,0,0,1,0,0,0},  //13
  {1,0,0,0,1,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,1,0,1,0,0,0,0},
  {0,1,0,1,0,1,0,0,0},
  {1,0,1,0,1,0,0,0,1},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,0,0,1,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,0,0,1,0,0,0,1,0},  //14
  {0,0,1,1,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {1,1,0,0,1,0,1,0,0},
  {0,0,1,1,0,0,1,0,0},
  {0,0,0,0,0,0,0,0,1},
  {0,0,0,1,1,0,0,0,0},
  {1,0,0,0,0,0,0,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,0,0,0,1,0,0,1,0},  //15
  {0,0,1,1,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {1,0,1,1,0,1,0,0,1},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,0,0,0,1,0},
  {1,0,0,0,0,1,1,0,1},
  {0,0,0,0,1,0,0,1,0}},
  
  {{0,0,0,0,0,0,0,0,0},  //16
  {0,0,1,0,0,0,0,0,1},
  {0,1,0,0,0,1,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,1,0,1,0,1,0},
  {0,0,1,0,1,0,0,0,0},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,1,0,1,0,1},
  {0,1,0,0,0,0,0,1,0}},
  
  {{0,1,0,0,0,0,0,0,0},  //17
  {1,0,1,0,0,1,1,0,0},
  {0,1,0,0,0,0,0,1,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,1,0,1,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,1,0,0,0,0,0,0,0},
  {0,0,1,1,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0}},
  
  {{0,0,0,1,0,0,0,0,0},  //18
  {0,0,0,0,1,0,1,0,0},
  {0,0,0,1,0,1,0,0,0},
  {1,0,1,0,0,0,1,0,0},
  {0,1,0,0,0,0,0,1,1},
  {0,0,1,0,0,0,0,0,1},
  {0,1,0,1,0,0,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0}},
  
  {{0,0,0,1,1,0,0,0,0},  //19
  {0,0,0,1,1,0,0,0,0},
  {0,0,0,0,0,1,0,1,0},
  {1,1,0,0,1,0,1,0,0},
  {1,1,0,1,0,0,0,1,1},
  {0,0,1,0,0,0,1,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,0,1,0,1,0,0,0,0},
  {0,0,0,0,1,0,0,0,0}},
  
  {{0,1,0,0,0,0,0,0,0},  //20
  {1,0,1,1,0,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,0,1,1,0,1,1,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,0,1,1,0,1},
  {0,0,0,0,0,0,0,1,0}},
  
  {{0,0,0,0,1,0,0,0,0},   //21
  {0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,0,0,0,0},
  {0,1,0,0,0,0,0,1,0},
  {1,1,1,0,0,0,1,0,1},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,1,0,0,1,0,1},
  {0,0,0,0,1,0,0,1,0}},
  
  {{0,0,0,0,1,0,0,1,0},   //22
  {0,0,0,1,1,0,0,0,0},
  {0,0,0,1,0,0,0,0,0},
  {0,1,1,0,0,0,0,0,0},
  {1,1,0,0,0,1,0,0,1},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,0,0,0,1,0},
  {1,0,0,0,0,1,1,0,1},
  {0,0,0,0,1,0,0,1,0}},
  
  {{0,0,0,0,1,0,0,0,0},   //23
  {0,0,0,0,1,1,0,0,0},
  {0,0,0,0,0,1,0,1,0},
  {0,0,0,0,1,0,0,0,0},
  {1,1,0,1,0,1,0,1,0},
  {0,1,1,0,1,0,0,0,1},
  {0,0,0,0,0,0,0,1,0},
  {0,0,1,0,1,0,1,0,1},
  {0,0,0,0,0,1,0,1,0}},
  
  {{0,0,0,1,0,0,0,0,0},   //24
  {0,0,0,0,1,0,0,0,1},
  {0,0,0,0,1,1,0,0,0},
  {1,0,0,0,1,0,1,1,0},
  {0,1,1,1,0,1,0,1,0},
  {0,0,1,0,1,0,0,0,0},
  {0,0,0,1,0,0,0,1,0},
  {0,0,0,1,1,0,1,0,1},
  {0,1,0,0,0,0,0,1,0}},
  
  {{0,0,0,0,1,0,0,1,0},   //25
  {0,0,0,1,0,1,0,0,0},
  {0,0,0,0,0,1,0,0,0},
  {0,1,0,0,0,0,0,1,0},
  {1,0,0,0,0,1,1,0,1},
  {0,1,1,0,1,0,0,0,1},
  {0,0,0,0,1,0,0,0,0},
  {1,0,0,1,0,0,0,0,0},
  {0,0,0,0,1,1,0,0,0}},
  
  {{0,1,0,0,1,0,0,0,0},   //26
  {1,0,1,0,1,0,0,0,1},
  {0,1,0,0,1,0,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {1,1,1,1,0,0,1,0,1},
  {0,0,0,0,0,0,0,1,0},
  {0,0,0,0,1,0,0,0,0},
  {0,0,0,1,0,1,0,0,0},
  {0,1,0,0,1,0,0,0,0}},
  
  {{0,1,0,0,0,1,0,0,0},   //27
  {1,0,0,0,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,1,1,1,0,0,1,1,0},
  {1,0,1,0,0,0,1,0,1},
  {0,0,0,0,1,1,0,0,0},
  {0,0,0,1,1,0,0,0,0},
  {0,0,0,0,0,1,0,0,0}},
  
  {{0,0,0,0,1,0,0,0,0},   //28
  {0,0,0,0,1,1,0,0,0},
  {0,0,0,0,1,1,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {1,1,1,1,0,0,1,1,1},
  {0,1,1,0,0,0,1,0,1},
  {0,0,0,0,1,1,0,0,0},
  {0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0}},
  
  {{0,1,0,0,0,0,0,1,0},   //29
  {1,0,1,1,1,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,1,0,0,1,0,0,0,0},
  {0,1,1,1,0,1,1,0,0},
  {0,0,0,0,1,0,0,1,0},
  {0,0,0,0,1,0,0,1,0},
  {1,0,0,0,0,1,1,0,1},
  {0,0,0,0,0,0,0,1,0}},
  
  {{0,0,0,1,1,0,0,0,0},  //30
  {0,0,0,1,1,0,0,0,0},
  {0,0,0,0,1,0,0,1,0},
  {1,1,0,0,1,0,1,0,0},
  {1,1,1,1,0,0,1,1,1},
  {0,0,0,0,0,0,0,0,1},
  {0,0,0,1,1,0,0,0,0},
  {0,0,1,0,1,0,0,0,0},
  {0,0,0,0,1,1,0,0,0}},
  
  {{0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0}},
};

void setup(){
  loadfile();
  exfont = loadFont("AgencyFB-Reg-80.vlw");
  no = loadFont("OCRAExtended-80.vlw");
  textFont(exfont);
  textSize(64*res*2);
  textAlign(CENTER,CENTER);
  // font setup
  
  act = this.getActivity();
  background(255);
  orientation(PORTRAIT);
  res = (float)width/1440 * 0.9f;
  r = width/11;
  // environment setup

  int offset = width/3;
  for(i=0;i<3;i++)for(j=0;j<3;j++) {
    x[3*i+j] = width*(1+2*j)/6;
    y[3*i+j] = height/2 + offset * i;
    ansx[3*i+j] = width*(2+j)/6;
    ansy[3*i+j] = height/6 + offset/2 * i;
  }
  // generate coordinates of all dots
}

void finish1(){
  fill(100);
  text("congratulation!", width/2, height/2 - 100);
  text("You have completed all stages", width/2, height/2 + 100);
  // when player cleared all stages
}

void bbutton(){
  fill(104);
  noStroke();
  rect(width-200*res,0,200*res,150*res);
  triangle(width-250*res,0, width-200*res, 0, width-200*res,150*res);
  fill(255);
  textSize(64*res*1.5);
  text("back", width-100*res, 70*res);
  // draw back button
}

void back() // background setup for stage mode
{
  stagenum(); // show current stage no.
  bbutton(); // show back button
  
  for(i=0;i<9;i++)for(j=i;j<9;j++){
    strokeWeight(5);
    stroke(0);
    if(ans[cnt][i][j]==1) line(ansx[i],ansy[i],ansx[j],ansy[j]);
  } // show answer
  
  noStroke();
  for(i=0;i<9;i++){
    fill(0);
    ellipse(ansx[i],ansy[i],5*size*res,5*size*res);
  } // show dots for answer
    
  noStroke();
  fill(200);
  for(i=0;i<9;i++) ellipse(x[i],y[i],10*size*res,10*size*res);
  fill(0);
  // show dots for player
}

void stagenum(){
  fill(154);
  noStroke();
  rect(0,0,320*res,150*res);
  triangle(320*res,150*res,320*res,0,370*res,0);  
  textSize(64*res*1.5);
  fill(255);
  text("stage",120*res,70*res);
  text(cnt+1,270*res,70*res);
  fill(0);
  // show current stage no.
}

void Arcadeback() // background setup for arcade mode
{
  bbutton(); // draw back button
  stagenum(); // show stage no.

  float timer = float(millis()-start);
  strokeWeight(10*res);
  stroke(104);
  fill(0);
  textFont(no);
  text(timer/1000,width/2.07 , width*90/1440);
  textFont(exfont);
  // show timer
  
  if(timer/1000>120&&gamemode==0 || cnt>=15&&gamemode==1) {
    restime=timer/1000;
    st=3;
  } // termination
  
  for(i=0;i<9;i++)for(j=i;j<9;j++){
    strokeWeight(5);
    stroke(0);
    if(tmp[i][j]==1) line(ansx[i],ansy[i],ansx[j],ansy[j]);
  } // show answer
  
  noStroke();
  for(i=0;i<9;i++){
    fill(0);
    ellipse(ansx[i],ansy[i],5*size*res,5*size*res);
  } // show dots for answer
    
  noStroke();
  fill(200);
  for(i=0;i<9;i++) ellipse(x[i],y[i],10*size*res,10*size*res);
  fill(0);
  // show dots for player
}

void init() // intialize
{
  for(i=0;i<9;i++){
    used[i]=0;
    route[i]=0;
    for(j=0;j<9;j++)cnct[i][j]=0;
    effect[i]=0;
  }
  current=-1;
  count=0;
}

void connect() // determines if vertex is connected
{
  for(i=0;i<9;i++){
    if(touches.length>0) if(dist(touches[0].x,touches[0].y,x[i],y[i])<r&&used[i]==0){
      if(current!=-1||touches.length>0){
        Vibrator vibrer = (Vibrator)   act.getSystemService(Context.VIBRATOR_SERVICE);
        vibrer.vibrate(10);
      } // vibration
      
      effect[i]=5; // ready for effect
      
      if(count!=0&&i%2==1&&route[count-1]+i==8){ 
        int prev=count-1;
        route[count]=4;
        used[4]=1;
        count++;
        cnct[4][route[prev]]=cnct[route[prev]][4]=1;
        current = i;
        route[count] = i;
        count++;
        used[i] = 1;
        cnct[4][i]=cnct[i][4]=1;
      }
      else if(count!=0&&i%2==0&&(i+route[count-1])%2==0&&i!=4&&route[count-1]!=4) {
        int prev=count-1;
        route[count]=(i+route[prev])/2;
        used[(i+route[prev])/2]=1;
        cnct[(i+route[prev])/2][route[prev]]=cnct[route[prev]][(i+route[prev])/2]=1;
        count++;
        current = i;
        route[count] = i;
        count++;
        used[i] = 1;
        cnct[(i+route[prev])/2][i]=cnct[i][(i+route[prev])/2]=1;
      } 
      else{
        int prev=count-1;
        current = i;
        route[count] = i;
        count++;
        used[i] = 1;
        if(prev!=-1)cnct[route[prev]][i]=cnct[i][route[prev]]=1;
      }
      // process with middle vertex
    }
  }
}

void convert() // generate random pattern for arcade mode
{
  int[] rrt = new int[20]; // random route 
  int[] check = new int[9]; // visited vertex
  int c=0, t=0, ttsum=0;
  
  int max = floor(random(4,8.99)); // set length
  
  for(i=0;i<9;i++)for(j=0;j<9;j++) tmp[i][j]=0; // initialize
  while(ttsum<max){
    t=floor(random(0,8.99)); // visit random vertex
    if(check[t]==0) // when it is unvisited vertex
    {
      check[t]=1;
      rrt[c]=t;
      if(c>0){
        if(rrt[c]%2==1&&rrt[c-1]+rrt[c]==8){ 
          tmp[4][rrt[c-1]]=tmp[rrt[c-1]][4]=1;
          tmp[4][rrt[c]]=tmp[rrt[c]][4]=1;
          check[4]=1;
        }
        else if(rrt[c]%2==0&&(rrt[c]+rrt[c-1])%2==0&&rrt[c]!=4&&rrt[c-1]!=4) {
          tmp[(rrt[c]+rrt[c-1])/2][rrt[c-1]]=tmp[rrt[c-1]][(rrt[c]+rrt[c-1])/2]=1;
          tmp[(rrt[c]+rrt[c-1])/2][rrt[c]]=tmp[rrt[c]][(rrt[c]+rrt[c-1])/2]=1;
          check[(rrt[c]+rrt[c-1])/2]=1;
        } 
        else{
          tmp[rrt[c-1]][rrt[c]]=tmp[rrt[c]][rrt[c-1]]=1;
        }
        // process with middle vertex
      }
      c++;
    }
    ttsum=0;
    for(i=0;i<9;i++) ttsum+=check[i];
  }
  h=0;
  int tsum=0;
  for(i=0;i<9;i++){
    tsum=0;
    for(j=0;j<9;j++){
      tsum+=tmp[i][j];
    }
    if(tsum>h)h=tsum;
  }
  if(h==2) convert(); // refresh if it is too east to solve
}

void check() // answer check in stage mode
{
  int s=0;
  for(i=0;i<9;i++)for(j=0;j<9;j++)if(cnct[i][j]!=ans[cnt][i][j])s++;
  if(cnt==30)
  {
    solved[29]=true;
    usersolve++;
    st=99;
    savefile();
  }
  else
  {
    if(s==0){
      solved[cnt]=true;
      usersolve++;
      cnt++;
      savefile();
    }
  }
}

void Arcadecheck() // answer check in arcade mode
{
  int s=0;
  for(i=0;i<9;i++)for(j=0;j<9;j++)if(cnct[i][j]!=tmp[i][j])s++;
  if(s==0&&count>0) {
    cnt++;
    count=0;
    for(i=0;i<9;i++)for(j=0;j<9;j++)tmp[i][j]=0;
    convert();
  }
}

void TimeAttackMain() // ready for time attack
{
  bbutton();
  fill(100);
  text("Solve as many stages", width/2, height/2-80);
  text("as possible in 120s", width/2, height/2+80);
  fill(225);
  ellipse(width/2, height - height/8, height/6, height/6);
  fill(100);
  text("START", width/2, height - height/8 );
}

void SpeedRunMain() // ready for speed run 
{
  bbutton();
  fill(100);
  text("Solve 15 stages", width/2, height/2-80);
  text("as fast as possible", width/2, height/2+80);
  fill(225);
  ellipse(width/2,height - height/8, height/6, height/6);
  fill(100);
  text("START", width/2, height - height/8 ); 
}

void RenderLine() // draw line
{
  stroke(12);
  strokeWeight(10);
    for(i=0;i<9;i++){
      for(j=i;j<9;j++){
        strokeWeight(10);
        stroke(0);
        if(cnct[i][j]==1)line(x[i],y[i],x[j],y[j]);
      } // draw line between vertex
      
      if(used[i]==1) {
        fill(0);
        ellipse(x[i],y[i],12*size*res,12*size*res);
        fill(0,0,0,0);
        stroke(0);
      } // draw big dot
    }
    if(touches.length>0) line(x[current],y[current],touches[0].x,touches[0].y); // draw line between vertex and finger
}

void Effect() // draw effect
{    
  strokeWeight(3);
  fill(0,0,0,0);
  for(i=0;i<9;i++)if(effect[i]>0 && effect[i]<10000) {
    stroke(0,0,0,map(10000-effect[i],0,10000,0,100));
    ellipse(x[i],y[i],sqrt(effect[i])*size*res,sqrt(effect[i])*size*res);
    effect[i]+=850;
  }
}

void arcadeMain() // main screen for arcade mode
{
  bbutton();
  fill(100);
  textSize(80*res*3);
  text("Arcade", width/2, height/7);
  textSize(64*res*2);
  text("Select Game Mode",width/2,height/2 - height/5); 
  textAlign(CENTER);
  strokeWeight(5);
  stroke(200);
  textSize(64*res*3);
  fill(225);
  rect(width/2-150*size*res, height/7*3-64*size*res,300*size*res,80*size*res);
  rect(width/2-150*size*res, height/7*4-64*size*res,300*size*res,80*size*res);
  fill(100);
  text("TIME ATTACK", width/2, height/7*3);
  text("SPEED RUN", width/2, height/7*4);
  textAlign(CENTER,CENTER);
}

void arcadeResult() // show result of arcade mode
{
   bbutton();
   fill(100);
   text("Your Result is",width/2,height/2-90);
   if(gamemode==0) text(cnt,width/2,height/2+90);
   else if(gamemode==1) text(restime,width/2,height/2+90);
}

void checkback(int n) // check if back button is pressed
{
  if(mouseX > width - 200 && mouseX < width && mouseY > 0 && mouseY < 100){
      st=n;
  }
}

void touchEnded() // when any button is pressed
{
  if(st==1){
    if(mouseX > width/2-150*size*res && mouseX < width/2+150*size*res && mouseY > height/7*3-64*size*res && mouseY < height/7*3+64*size*res) {
      st=101;
    }
    if(mouseX > width/2-150*size*res && mouseX < width/2+150*size*res && mouseY > height/7*4-64*size*res && mouseY < height/7*4+64*size*res) {
      st=20;
    }
  }
  else if(st==101){
    for(i=0;i<15;i++)
    {
      if(mouseX>width/4*((i%3)+1)-40*size*res && mouseX<width/4*((i%3)+1)+40*size*res &&  mouseY<height/6*(i/3+1)+40*size*res && mouseY>height/6*(i/3+1)-40*size*res && i<usersolve+1)
      {
        st=11;
        cnt=i;
      }
    }
    if(mouseX > width/10*9-30*size*res-45*size*res && mouseX < width/10*9-30*size*res+45*size*res && mouseY > height/10*9+35*size*res-20*size*res && mouseY < height/10*9+35*size*res-20*size*res+20*size*res){
      st=102;
    }
    checkback(1);
  }
  else if(st==102){
    for(i=0;i<15;i++)
    {
      if(mouseX>width/4*((i%3)+1)-40*size*res && mouseX<width/4*((i%3)+1)+40*size*res &&  mouseY<height/6*(i/3+1)+40*size*res && mouseY>height/6*(i/3+1)-40*size*res && i+15<usersolve+1)
      {
        st=11;
        cnt=i+15;
      }
    }
    if(mouseX > width/10*1+30*size*res-45*size*res && mouseX < width/10*1+30*size*res+45*size*res && mouseY > height/10*9+35*size*res-20*size*res && mouseY < height/10*9+35*size*res-20*size*res+20*size*res){
      st=101;

    }
    checkback(1);
  }
  else if(st==11){
    if(mouseX > width - 200 && mouseX < width && mouseY > 0 && mouseY < 100)
    {
      if(cnt<15) st=101;
      else st=102;
    } 
  }
  else if(st==21){
    if(dist(mouseX,mouseY,width/2,height - height/8)<height/12) {
      st=215;
      start=millis();
      convert();
    }
    checkback(20);
  }
  else if(st==22){
    if(dist(mouseX,mouseY,width/2,height - height/8)<height/12) {
      st=215;
      start=millis();
      convert();
    }
    checkback(20);
  }
  else if(st==3){
    checkback(20);
  }
  else if(st==215){
    checkback(20);
  }
  else if(st==20){
    checkback(1);
   if(mouseX > width/2-150*size*res && mouseX < width/2+150*size*res && mouseY > height/7*3-64*size*res && mouseY < height/7*3+64*size*res) {
     cnt=0;
     st=21;
     gamemode=0;
    }
    if(mouseX > width/2-150*size*res && mouseX < width/2+150*size*res && mouseY > height/7*4-64*size*res && mouseY < height/7*4+64*size*res) {
     cnt=0;
     st=22;
     gamemode=1;
    }
  }
  else if(st==99){
     checkback(102);
  }
}

int usersolve=0;

void savefile(){
  String out[]={""};
  for(int i=0;i<usersolve;i++) out[0]=out[0]+"a";
  saveStrings("save.txt",out);
}

void loadfile(){
  String in[]={""};
  if(loadStrings("save.txt")==null){
    saveStrings("save.txt",in);
    usersolve=0;
  } else {
    in = loadStrings("save.txt");
    usersolve = in[0].length();
  }
}

void draw()
{
  background(255);  // initializing
  if(st==1) {
    Main();
  }
  else if(st==101){
    Stage1();
  }
  else if(st==102){
    Stage2();
  }
  else if(st==11){
    if(cnt==30)finish1(); 
    back();
    connect();
    fill(0);
    if(touches.length>0&&current!=-1&&mousePressed) {
      RenderLine();
      Effect();
    }
    else {
      check();
      init();
    }
    if(cnt==30)
      finish1();
  }
  else if(st==21) {
    TimeAttackMain();
  }
  else if(st==22){
    SpeedRunMain();
  }
  else if(st==215){
    Arcadeback();
    connect();

    if(touches.length>0&&current!=-1&&mousePressed) {
     RenderLine();
     Effect();
    }
    else {
      Arcadecheck();
      init();
    } 
 }
 else if(st==3){
   arcadeResult();
 }
 else if(st==20){
   arcadeMain();
 }
 else if(st==99){
   bbutton();
   finish1(); 
 }
}

void Stage1() // show stage 1~15
{
  bbutton();
  textAlign(CENTER);
  textSize(64*res*3);
  strokeWeight(5);
  for(i=0;i<15;i++){
    if(i<usersolve) fill(200,255,200);
    else if(i==usersolve) fill(225);
    else fill(200);
    stroke(200);
    rect(width/4*(i%3+1)-40*size*res, height/6*(i/3+1)-60*size*res,80*size*res,80*size*res);
    fill(100);
    text(i+1, width/4*(i%3+1), height/6*(i/3+1)+5);
  }
  fill(100);
  textSize(45*res*3);
  text("next", width/10*9-30*size*res, height/10*9+35*size*res);
  textSize(64*res*3);
  textAlign(CENTER,CENTER);
}

void Stage2() // show stage 16~30
{
  bbutton();
  textAlign(CENTER);
  textSize(64*res*3);
  strokeWeight(5);
  for(i=0;i<15;i++){
    if(i+15<usersolve) fill(200,255,200);
    else if(i+15==usersolve) fill(225);
    else fill(200);
    stroke(200);
    rect(width/4*(i%3+1)-40*size*res, height/6*(i/3+1)-60*size*res,80*size*res,80*size*res);
    fill(100);
    text(i+16, width/4*(i%3+1), height/6*(i/3+1)+5);
  }
  fill(100);
  textSize(45*res*3);
  text("prev", width/10*1+30*size*res, height/10*9+35*size*res);
  textSize(64*res*3);
  textAlign(CENTER,CENTER);
}

void Main() // draw main screen
{
  textAlign(CENTER,CENTER);
  strokeWeight(5);
  fill(100);
  stroke(200);
  textSize(80*res*3);
  text("Pattern Puzzle", width/2, height/7);
  textAlign(CENTER);
  textSize(64*res*3);
  fill(225);
  rect(width/2-150*size*res, height/7*3-64*size*res,300*size*res,80*size*res);
  rect(width/2-150*size*res, height/7*4-64*size*res,300*size*res,80*size*res);
  fill(100);
  text("STAGE", width/2, height/7*3);
  text("ARCADE", width/2, height/7*4);
  textSize(64*res);
  text("Subeen & Hanho", width/2, height - height/5);
  textAlign(CENTER,CENTER);
}