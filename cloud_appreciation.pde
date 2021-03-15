
color backCol=color(0);
int cloudSelected=0;

PImage closet;

ArrayList<PImage> bigs=new ArrayList<PImage>();
ArrayList<PImage> smalls=new ArrayList<PImage>();

ArrayList<Item> items=new ArrayList<Item>();
ArrayList<Item> clouds=new ArrayList<Item>();

String[] cloudPaths=new String[]{"cloud_new.png", "cloud_tpose.png", "cloud_old.png"}; 
String[] clothingPaths=new String[] { "dress1.png", "dress2.png", "dress3.png", "dress4.png", "aerith.png", 
  "barret.png", "doncorneo.png", "reno.png", "tifa.png" };
String[] weaponsPaths=new String[]{ "buster.png", "gun.png", "masamune.png"};

void setup() {
  size(1920, 1080);

  preloadImages();
  initCloud();
  initItems();
}

void preloadImages() {
  closet=loadImage("data/curtain.png");
  closet.resize(width/2, height);

  for (String s : cloudPaths) {
    bigs.add(loadImage("data"+File.separator+s));
    addSmallImage("data"+File.separator+s);
  }

  for (String s : clothingPaths) {
    bigs.add(loadImage("data"+File.separator+s));
    addSmallImage("data"+File.separator+s);
  }
  for (String s : weaponsPaths) {
    bigs.add(loadImage("data"+File.separator+s));
    addSmallImage("data"+File.separator+s);
  }
}

void addSmallImage(String path) {
  PImage aux=loadImage(path); 
  aux.resize(aux.width/3, aux.height/3); 
  smalls.add(aux);
}

void initItems() {

  for (int i=0; i<bigs.size()-clouds.size(); i++) {
    int index=clouds.size()+i;
    PImage big=bigs.get(index); 
    PImage small=smalls.get(index); 
    Item item=new Item(width/2+((i)%3)*width/6+width/24, (i/3)*height/+100, small.width, small.height, big, small, false);
    items.add(item );
  }
}

void initCloud() {

  clouds.add(new Item(width/6, 30, bigs.get(0).width, bigs.get(0).height, bigs.get(0), smalls.get(0), true));
  clouds.get(0).setClickable(false);

  clouds.add(new Item(width/10, 30, bigs.get(1).width, bigs.get(1).height, bigs.get(1), smalls.get(1), true));
  clouds.get(1).setClickable(false);

  clouds.add(new Item(width/10, 30, bigs.get(2).width, bigs.get(2).height, bigs.get(2), smalls.get(2), true));
  clouds.get(2).setClickable(false);
}

void draw() {
  background(backCol); 
  renderDresserBack(); 
  renderCloud();
  renderItems(); 
  updateItems(); 
  renderCommandBox();
}

void renderDresserBack() {
  push(); 
  fill(69, 1, 1); 
  noStroke(); 
  rect(width/2, 0, width/2, height); 
  image(closet, width/2, 0); 
  pop();
}

void renderCommandBox() {
  int boxX=width-300;
  push(); 
  fill(0, 100); 
  noStroke(); 
  rect(boxX, 0, 300, 170); 
  fill(255); 
  textSize(20); 
  text("Commands:", boxX+70, 30); 
  text("Drag the apparel over Cloud", boxX+10, 60);
  text("Save image: SPACEBAR", boxX+10, 90); 
  text("Change background color: B", boxX+10, 120); 
  text("Change Cloud pose: C", boxX+10, 150);
  pop();
}

void renderCloud() {
  clouds.get(cloudSelected).render();
}

void renderItems() {
  for (Item item : items) {
    item.render();
  }
}

void updateItems() {
  for (Item item : items) {
    if (item.inside(mouseX, mouseY)) {
      item.move();
    }
  }
}

int getItemClicked() {
  for (int i=0; i< items.size(); i++) { 
    if ( items.get(i).captured) {
      return i;
    }
  }
  return 0;
}

void keyPressed() {
  if (key==' ') {
    PImage temp=get(0, 0, width/2, height); 
    temp.save("data/"+frameCount+".png");
  } else if (key=='b' ||key=='B') {
    backCol=color(random(0, 80), random(0, 80), random(0, 80));
  } else if (key=='c'||key=='C') {
    cloudSelected++;
    if (cloudSelected==clouds.size()) {
      cloudSelected=0;
    }
  }
}
