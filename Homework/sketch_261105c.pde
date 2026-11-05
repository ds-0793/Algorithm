int cnt = 3;
int Value[][] = new int[4][101];
int DP[][] = new int[4][101];
int i, j;

for (i = 0; i < 3; i++) {
  for (j = 0; j < cnt; j++) {
    Value[i][j] = (int) random(-10, 10);
    print(nfp(Value[i][j], 4) + " ");
  }
  println();
}

DP[0][0] = Value[0][0];
DP[1][0] = Value[1][0];
DP[2][0] = Value[2][0];
DP[3][0] = Value[0][0] + Value[2][0];

for (j = 1; j < cnt; j++) {
  int w0 = Value[0][j];
  int w1 = Value[1][j];
  int w2 = Value[2][j];
  int w3 = Value[0][j] + Value[2][j];
  
  DP[0][j] = w0 + max(DP[1][j-1], DP[2][j-1]);
  DP[1][j] = w1 + max(max(DP[0][j-1], DP[2][j-1]), DP[3][j-1]);
  DP[2][j] = w2 + max(DP[0][j-1], DP[1][j-1]);
  DP[3][j] = w3 + DP[1][j-1];
}

int finalMax = max(max(DP[0][cnt-1], DP[1][cnt-1]), max(DP[2][cnt-1], DP[3][cnt-1]));

println(finalMax);
