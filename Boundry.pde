abstract class Boundry{
  // A boundary is a simple rectangle with x,y,width,and height
  // x-coordinates
  float x;
  // y-coordinates
  float y;
  //width of rectangle
  float w;
  //height of rectangle
  float h;
  // rgb of the rectangle
  int f1,f2,f3;

  Boundry(float x_, float y_, float w_, float h_, int f1_, int f2_, int f3_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    f1 = f1_;
    f2 = f2_;
    f3 = f3_;
  }
  abstract void display();
}
