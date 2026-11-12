
Walker[] walkers;

int frameExport = 1;
int total = 20;
int maxWalkers = 250;

color rosa = #9e3970;
color amarillo = #FDFFB2;
color azul = #B2BFFF;
color verde = #bfdd83;

void setup() {
  size(1080, 1920);
  background(#FAFAF2);
  frameRate(25);

  walkers = new Walker[maxWalkers];

  // Creamos los primeros agentes
  for (int i = 0; i < total; i++) {

    walkers[i] = new Walker(
      random(width),
      random(height),
      random(10, 35),
      elegirColor()
    );
  }
}

void draw() {

  // Cada agente se mueve y deja huella
  for (int i = 0; i < total; i++) {

    walkers[i].display();
    walkers[i].step();

    // Posibilidad de crear un nuevo agente
    if (random(1) < 0.03 && total < maxWalkers) {

      walkers[total] = new Walker(
        walkers[i].posx,
        walkers[i].posy,
        random(10, 50),
        elegirColor()
      );

      total++;
    }
  }

  // Exportar frames
  if (frameExport <= 250) {

    saveFrame("frames/frame_circulos-" + nf(frameExport, 4) + ".png");

    println("Guardando frame: " + frameExport);

    frameExport++;
  }

  if (frameExport > 250) {
    println("EXPORTACIÓN TERMINADA");
    noLoop();
  }
}


// ELEGIR COLOR ALEATORIO

color elegirColor() {

  float eleccion = random(4);

  if (eleccion < 1) {
    return rosa;
  } else if (eleccion < 2) {
    return amarillo;
  } else if (eleccion < 3) {
    return azul;
  } else {
    return verde;
  }
}


// CLASE WALKER

class Walker {

  float posx;
  float posy;
  float tamaño;

  color c;

  int choice;

  Walker(float x, float y, float t, color colorWalker) {

    posx = x;
    posy = y;
    tamaño = t;
    c = colorWalker;
  }

  void display() {

    noStroke();
    fill(c);

    // CÍRCULO
    ellipse(
      posx,
      posy,
      tamaño,
      tamaño
    );
  }

  void step() {

    choice = floor(random(4));

    if (choice == 0) {
      posx += tamaño;
    } else if (choice == 1) {
      posx -= tamaño;
    } else if (choice == 2) {
      posy += tamaño;
    } else {
      posy -= tamaño;
    }

    // Si sale de la pantalla, vuelve a entrar
    posx = (posx + width) % width;
    posy = (posy + height) % height;
  }
}
