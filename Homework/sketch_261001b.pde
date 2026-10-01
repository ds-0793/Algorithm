int n = 16;
int m = n; // selection Sort
int[][] arr;

int loop;

void setup() {
  size(800, 600);
  intArr();
  printArr();
  selectionSorting();
  printArr();
  loop = 0;
}

void intArr() {
  int i;
  arr = new int[m][n];

  for(i=0; i<n; i++) {
    arr[0][i] = (int) random(100);
  }
}

void printArr() {
  int i, j;

  for(j=0; j<m; j++) {
    for(i=0; i<n; i++) {
      print(arr[j][i]);
      print(" ");
    }
    println();
  }
}

void selectionSorting() {
  int i, j, max, index, tmp;

  for(i=0; i<m-1; i++) {
    max = index = -1;

    copy(i, i+1);
    loop++;

    for(j=0; j<n-i; j++) {
      if(max < arr[loop][j]) {
        index = j;
        max = arr[loop][j];
      }
    }

    tmp = arr[loop][n-i-1];
    arr[loop][n-i-1] = max;
    arr[loop][index] = tmp;
  }
}

void draw() {
  int i;
  float mx, dx, my, dy;

  background(32);

  mx = my = 20;
  dx = (width-2*mx)/n;
  dy = (height-2*my)/100;

  for(i=0; i<n; i++) {
    rect(mx+dx*i, height-dy*arr[loop][i]-my, dx, dy*arr[loop][i]);
  }
}

void keyPressed() {
  if(key == 'n') {
    loop++;

    if(loop >= m) {
      loop = 0;
    }
  }
}

void mousePressed() {
  if(mouseButton == RIGHT) {
    loop++;

    if(loop >= m) {
      loop = 0;
    }
  }
  else if(mouseButton == LEFT) {
    loop--;

    if(loop < 0) {
      loop = m-1;
    }
  }
}

void copy(int i, int j) {
  int k;

  for(k=0; k<n; k++) {
    arr[j][k] = arr[i][k];
  }
}
