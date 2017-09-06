PImage header;
PImage empty;
PImage flag;
PImage bomb;
PImage start;
PImage lose;
PImage winner;
PImage num1;
PImage num2;
PImage num3;
PImage num4;
PImage num5;
PImage num6;
PImage num7;
PImage num8;
field[][] board;
int set;
int setx;
int sety;
void setup()
{
  size(500,600);
  board=new field[10][10];
  header=loadImage("header.png");
  header.resize(500,100);
  image(header,0,0);
  empty=loadImage("empty.png");
  empty.resize(50,50);
  start=loadImage("start.png");
  start.resize(50,50);
  flag=loadImage("flag.png");
  flag.resize(50,50);
  num1=loadImage("1.png");
  num1.resize(50,50);
  num2=loadImage("2.png");
  num2.resize(50,50);
  num3=loadImage("3.png");
  num3.resize(50,50);
  num4=loadImage("4.png");
  num4.resize(50,50);
  num5=loadImage("5.png");
  num5.resize(50,50);
  num6=loadImage("6.png");
  num6.resize(50,50);
  num7=loadImage("7.png");
  num7.resize(50,50);
  num8=loadImage("8.png");
  num8.resize(50,50);
  bomb=loadImage("bomb.png");
  bomb.resize(50,50);
  lose=loadImage("lose.png");
  lose.resize(500,200);
  winner=loadImage("win.png");
  winner.resize(500,200);
  for(int i=0;i<500;i+=50)
  {
    for(int j=100;j<600;j+=50)
    {
      image(start,i,j);
    }
  }
  for(int i=0;i<10;i++)
  {
    for(int j=0;j<10;j++)
    {
      board[i][j]=new field(false,i,j);
    }
  }
  set=0;
  while(set<9)
  {
    setx=int(random(10));
    sety=int(random(10));
    if(!board[setx][sety].check())
    {
      board[setx][sety].charge();
      set++;
    }
  }
  
}
void leftClick(int x,int y)
{
  y-=100;
  x=x/50;
  y=y/50;
  int count=0;
  //print(x+" "+y+"\n");
  board[x][y].open();
  if(board[x][y].check())
  {
    image(bomb,x*50,y*50+100);
    image(lose,0,200);
  }
  else
  {
    int startPosX = (x - 1 < 0) ? x : x-1;
    int startPosY = (y - 1 < 0) ? y : y-1;
    int endPosX =   (x + 1 > 9) ? x : x+1;
    int endPosY =   (y + 1 > 9) ? y : y+1;
    for (int rowNum=startPosX; rowNum<=endPosX; rowNum++)
    {
      for (int colNum=startPosY; colNum<=endPosY; colNum++) 
      {
        if(board[rowNum][colNum].check())
        {
          count++;
        }
      }
    }
    if(count==0)
    {
      image(empty,x*50,y*50+100);
      for (int rowNum=startPosX; rowNum<=endPosX; rowNum++)
      {
        for (int colNum=startPosY; colNum<=endPosY; colNum++) 
        {
          if(!board[rowNum][colNum].opened())
          {
            leftClick( (rowNum)*50,(colNum)*50+100);
          }
        }
      }
    }
    else if(count==1)
    {
      image(num1,x*50,y*50+100);
    }
    else if(count==2)
    {
      image(num2,x*50,y*50+100);
    }
    else if(count==3)
    {
      image(num3,x*50,y*50+100);
    }
    else if(count==4)
    {
      image(num4,x*50,y*50+100);
    }
    else if(count==5)
    {
      image(num5,x*50,y*50+100);
    }
    else if(count==6)
    {
      image(num6,x*50,y*50+100);
    }
    else if(count==7)
    {
      image(num7,x*50,y*50+100);
    }
    else if(count==8)
    {
      image(num8,x*50,y*50+100);
    }
  }
}
void rightClick(int x,int y)
{
  y-=100;
  x=x/50;
  y=y/50;
  //print(x+" "+y+"\n");
  board[x][y].flag();
  if(board[x][y].flagged())
  {
    image(flag,x*50,y*50+100);
  }
  else
  {
    image(start,x*50,y*50+100);
  }
}
void draw()
{
  boolean win=true;
  for(int i=0;i<10;i++)
  {
   for(int j=0;j<10;j++)
   {
    if(!(board[i][j].check() || board[i][j].opened()))
    {
      win=false;
    }
   }
  }
  if(win==true)
  {
    image(winner,0,200);
  }
}
void mousePressed()
{
  if(mousePressed && (mouseButton==LEFT)&& mouseY>100)
  {
    //print(mouseX+" "+mouseY+"\n");
    leftClick(mouseX,mouseY);
  }
  if(mousePressed && (mouseButton==RIGHT)&& mouseY>100)
  {
    rightClick(mouseX,mouseY);
  }
}
public class field
{
  private boolean mine;
  private boolean flagged;
  private boolean opened;
  private int x;
  private int y;
  
  public field(boolean m,int xx,int yy)
  {
    mine=m;
    flagged=false;
    opened=false;
    x=xx;
    y=yy;
  }
  public boolean check()
  {
     return mine; 
  }
  public void charge()
  {
    mine=true;
  }
  public boolean flagged()
  {
   return flagged; 
  }
  public void flag()
  {
   flagged=!flagged;
  }
  public boolean opened()
  {
   return opened; 
  }
  public void open()
  {
   opened=true; 
  }
  public int getX()
  {
   return x; 
  }
  public int getY()
  {
   return y; 
  }
}