class Item {
  PVector pos;
  float xDiff, yDiff;
  int w, h;
  PImage big;
  PImage small;
  boolean isBig=true;
  boolean captured=false;
  boolean clickable=true;

  Item(int x, int y, int w, int h, PImage big, PImage small, boolean isBig) {
    this.pos=new PVector(x, y);
    this.w=w;
    this.h=h;
    this.big=big;
    this.small=small;
    this.isBig=isBig;
  }

  boolean inside(int x, int y) {
    return x>pos.x && x<pos.x+w&&y>pos.y && y<pos.y+h;
  }

  void setClickable(boolean clickable) {
    this.clickable=clickable;
  }

  void setIsBig(boolean isBig) {
    this.isBig=isBig;
  }

  void move() {
    if (clickable) {

      if (inside(mouseX, mouseY) & mousePressed &&!captured) {
        xDiff=pos.x-mouseX;
        yDiff=pos.y-mouseY;
        captured=true;
      }

      if (!mousePressed) { 
        captured=false;
      }
      if (captured) {
        pos.x=mouseX+xDiff;
        pos.y=mouseY+yDiff;
        if (pos.x>width/2) {
          if (isBig) {
            w=small.width;
            h=small.height;
            isBig=false;
          }
        } else {
          if (!isBig) {
            w=big.width;
            h=big.height;
            isBig=true;
          }
        }
      }
    }
  }


  void render() {
    if (isBig) {
      image(big, pos.x, pos.y);
    } else {
      image(small, pos.x, pos.y);
    }
  }
}
