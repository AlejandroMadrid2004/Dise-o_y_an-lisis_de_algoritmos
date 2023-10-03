int R[][] = new int[8][8];

void setup() {
  size(800, 800);
  background(255);
  int x1 = 0, y1 = 0;
  int x2 = 100, y2 = 0;
  
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 4; j++) {
      if (i % 2 == 0) {
        drawRect(x1, y1, x2, y2);
      } else {
        drawRect(x2, y2, x1, y1);
      }
      x1 += 200;
      x2 += 200;
    }
    x1 = 0;
    x2 = 100;
    y1 += 100;
    y2 += 100;
  }
  resolverOchoReinas(R, 0, 0);
}

//Fila = x, Columna = y

boolean esValido(int R[][], int x, int y) {
  // Verifica si una posición es válida para colocar una reina
  boolean resultado = true; 
  
  // Verificar la fila actual
  for (int i = 0; i < y; i++) {
    if (R[x][i] == 1) {
      resultado = false;
      return resultado;
    }
  }
  
  // Verificar diagonal superior izquierda
  for (int i = x, j = y; i >= 0 && j >= 0; i--, j--) {
    if (R[i][j] == 1) {
      resultado = false;
      return resultado;
    }
  }
  
  // Verificar diagonal inferior izquierda
  for (int i = x, j = y; i < 8 && j >= 0; i++, j--) {
    if (R[i][j] == 1) {
      resultado = false;
      return resultado;
    }
  }
  
  return true;
}

boolean resolverOchoReinas(int R[][], int x, int y) {
  // Caso base: si todas las reinas están colocadas, retorna true
  boolean resultado = true;
  if (y >= 8) {
    return resultado;
  }

  // Recorre todas las filas en esta columna
  for (int i = 0; i < 8; i++) {
    // Verifica si es válido colocar una reina en esta posición
    if (esValido(R, i, y)) {
      // Coloca una reina en esta posición
      R[i][y] = 1;

      // Recursivamente coloca las reinas en las columnas restantes
      if (resolverOchoReinas(R, 0, y + 1)) {
        return resultado;
      }

      // Si no conduce a una solución, retrocede y prueba la siguiente fila
      R[i][y] = 0;
    }
  }

  // Si no se encuentra una posición válida en ninguna fila de esta columna, retorna falso
  resultado = false;
  return resultado;
}

void drawRect(int x1, int y1, int x2, int y2) {
  fill(255, 255, 255);
  rect(x1, y1, 100, 100);
  fill(0, 0, 0);
  rect(x2, y2, 100, 100);
}

void draw() {
  int x = 0;
  int y = 0;
  
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (R[i][j] == 1) {
        fill(255, 0, 0);
        circle(x + 50, y + 50, 80);
      }
      x += 100;
    }
    x = 0;
    y += 100;
  }
}
