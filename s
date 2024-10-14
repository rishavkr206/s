1)
#include <stdio.h>
#include <stdlib.h>
#define SIZE 1000
 
int count = 0;
 
void merge(int a[], int l, int m, int r) {
int i = l, j = m + 1, k = 0;
int b[r - l + 1];
 
while (i <= m && j <= r) {
b[k++] = (a[i] < a[j]) ? a[i++] : a[j++];
count++;
}
 
while (i <= m) b[k++] = a[i++];
while (j <= r) b[k++] = a[j++];
 
for (i = l, k = 0; i <= r; i++, k++) a[i] = b[k];
}
 
void mergeSort(int a[], int l, int r) {
if (l < r) {
int m = (l + r) / 2;
mergeSort(a, l, m);
mergeSort(a, m + 1, r);
merge(a, l, m, r);
}
}
 
int main() {
int a[SIZE], x[SIZE], y[SIZE], z[SIZE], n;
printf("Enter size of array: ");
scanf("%d", &n);
 
printf("Enter elements: ");
for (int i = 0; i < n; i++) scanf("%d", &a[i]);
 
mergeSort(a, 0, n - 1);
printf("Sorted array: ");
for (int i = 0; i < n; i++) printf("%d ", a[i]);
printf("\nCount = %d\n", count);
 
printf("\nSize\tASC\tDESC\tRAND\n");
for (int i = 16; i <= SIZE / 4; i *= 2) {
for (int j = 0; j < i; j++) {
x[j] = j;
y[j] = i - j - 1;
z[j] = rand() % i;
}
count = 0; mergeSort(x, 0, i - 1); int c1 = count;
count = 0; mergeSort(y, 0, i - 1); int c2 = count;
count = 0; mergeSort(z, 0, i - 1); int c3 = count;
printf("%d\t%d\t%d\t%d\n", i, c1, c2, c3);
}
return 0;
}
 
2)
 
#include <stdio.h>
#include <stdlib.h>
int topo[10], k;
 
void dfs(int a[][10], int n, int v[], int source) {
int i;
 
v[source] = 1;
 
for (i = 1; i <= n; i++) {
if (!v[i] && (a[source][i])) {
dfs(a, n, v, i);
}
}
 
topo[++k] = source;
}
 
int main() {
int n, a[10][10], i, v[10] = {}, j;
 
printf("\nEnter the number of nodes : ");
scanf("%d", &n);
 
for (i = 1; i <= n; i++)
for (j = 1; j <= n; j++)
scanf("%d", &a[i][j]);
 
// the printing of the graph is optional
printf("\nThe grpah is as follows :\n");
 
for (i = 1; i <= n; i++) {
for (j = 1; j <= n; j++)
printf("%d ", a[i][j]);
 
printf("\n");
}
 
for (i = 1; i <= n; i++) {
if (v[i] == 0)
dfs(a, n, v, i);
}
 
printf("\nTopological Ordering is : ");
 
for (i = k; i >= 1; i--)
printf("%d ", topo[i]);
 
printf("\n");
 
return 0;
}
 
3)
#include <stdio.h>
#include <string.h>
 
#define SIZE 256
int Table[SIZE];
 
void shiftTable(char p[]) {
int m = strlen(p);
for (int i = 0; i < SIZE; i++) Table[i] = m;
for (int i = 0; i < m - 1; i++) Table[p[i]] = m - 1 - i;
}
 
int Horspool(char t[], char p[]) {
int m = strlen(p), n = strlen(t);
shiftTable(p);
for (int i = m - 1; i < n;) {
int k = 0;
while (k < m && p[m - 1 - k] == t[i - k]) k++;
if (k == m) return i - m + 1;
i += Table[t[i]];
}
return -1;
}
 
int main() {
char t[250], p[10];
printf("Enter Text: ");
gets( t);
printf("Enter Pattern: ");
gets( p);
 
int pos = Horspool(t, p);
if (pos == -1)
printf("Pattern not found\n");
else
printf("Pattern found at index %d\n", pos);
 
return 0;
}
 
4)
#include <stdio.h>
 
int n, W, w[10], v[10], V[10][10], x[10];
 
int max(int a, int b) {
return (a > b) ? a : b;
}
 
void display() {
int i = n, j = W;
while (i > 0 && j > 0) {
if (V[i][j] != V[i - 1][j]) {
x[i] = 1;
j -= w[i];
}
i--;
}
}
 
int main() {
printf("Enter number of objects: ");
scanf("%d", &n);
printf("Enter weights: ");
for (int i = 1; i <= n; i++) scanf("%d", &w[i]);
printf("Enter profits: ");
for (int i = 1; i <= n; i++) scanf("%d", &v[i]);
printf("Enter knapsack capacity: ");
scanf("%d", &W);
 
for (int i = 0; i <= n; i++)
for (int j = 0; j <= W; j++)
V[i][j] = (i == 0 || j == 0) ? 0 : (w[i] > j) ? V[i - 1][j] : max(V[i - 1][j], V[i - 1][j - w[i]] + v[i]);
 
display();
printf("\nMax profit = %d\nObjects included:\n", V[n][W]);
for (int i = 1; i <= n; i++)
if (x[i]) printf("Object %d\n", i);
 
return 0;
}
5)
#include <stdio.h>
#define INF 999
 
void dijkstra(int cost[10][10], int n, int src, int dist[10], int visited[10]) {
visited[src] = 1;
 
for (int i = 1; i <= n; i++) {
int min = INF, u = -1;
for (int j = 1; j <= n; j++) {
if (!visited[j] && dist[j] < min) {
min = dist[j];
u = j;
}
}
 
if (u == -1) break; // All nodes processed
visited[u] = 1;
 
for (int j = 1; j <= n; j++) {
if (!visited[j] && dist[u] + cost[u][j] < dist[j]) {
dist[j] = dist[u] + cost[u][j];
}
}
}
}
 
int main() {
int n, cost[10][10], dist[10], visited[10] = {0}, src;
 
printf("Enter number of nodes: ");
scanf("%d", &n);
 
printf("Enter cost adjacency matrix:\n");
for (int i = 1; i <= n; i++)
for (int j = 1; j <= n; j++)
scanf("%d", &cost[i][j]);
 
printf("Enter source node: ");
scanf("%d", &src);
 
for (int i = 1; i <= n; i++)
dist[i] = cost[src][i]; // imp hai
 
dijkstra(cost, n, src, dist, visited);
 
printf("Shortest distances from node %d:\n", src);
for (int i = 1; i <= n; i++)
printf("%d -> %d = %d\n", src, i, dist[i]);
 
return 0;
}
 
6)
#include <stdio.h>
#include <stdlib.h>
 
int w[10], x[10], d, b = 1;
 
void findSubset(int s, int k, int r) {
x[k] = 1;
if (s + w[k] == d) {
printf("Subset %d:\n", b++);
for (int i = 1; i <= k; i++) if (x[i]) printf("%d\t", w[i]);
printf("\n");
} else if (s + w[k] + w[k + 1] <= d) {
findSubset(s + w[k], k + 1, r - w[k]);
}
if (s + r - w[k] >= d && s + w[k + 1] <= d) {
x[k] = 0;
findSubset(s, k + 1, r - w[k]);
}
}
 
int main() {
int n, sum = 0;
printf("Enter the number of elements: ");
scanf("%d", &n);
printf("Enter %d elements in increasing order:\n", n);
for (int i = 1; i <= n; i++) {
scanf("%d", &w[i]);
sum += w[i];
}
printf("Enter the subset max value: ");
scanf("%d", &d);
if (sum < d || w[1] > d) {
printf("No solutions\n");
return 0;
}
findSubset(0, 1, sum);
if (b == 1) printf("No solutions\n");
return 0;
}
 
7)
#include <stdio.h>
#include <stdlib.h>
 
int x[10], c = 1;
 
void display(int n) {
printf("Solution %d:\n", c++);
for (int i = 1; i <= n; i++) {
for (int j = 1; j <= n; j++)
printf(x[i] == j ? "Q\t" : "-\t");
printf("\n");
}
}
 
int canPlace(int k, int i) {
for (int j = 1; j < k; j++)
if (x[j] == i || abs(x[j] - i) == abs(j - k))
return 0;
return 1;
}
 
void solveNQueens(int k, int n) {
for (int i = 1; i <= n; i++) {
if (canPlace(k, i)) {
x[k] = i;
if (k == n)
display(n);
else
solveNQueens(k + 1, n);
}
}
}
 
int main() {
int n;
printf("Enter the number of queens: ");
scanf("%d", &n);
solveNQueens(1, n);
if (c == 1)
printf("No solutions!");
}
 
8)
#include<stdio.h>
#include<stdlib.h>
#define SIZE 1000
 
int count;
void swap(int *a, int *b)
{
int t = *a;
*a = *b;
*b = t;
}
 
int partition(int arr[], int low, int high)
{
int pivot = arr[high];
int i = (low - 1);
for(int j = low; j <= high -1; j++)
{
 
if(arr[j] < pivot)
{
i++;
swap(&arr[i], &arr[j]);
}
count++;
}
swap(&arr[i+1], &arr[high]);
return (i+1);
}
 
void quicksort(int arr[], int low, int high)
{
if(low < high)
{
int pi = partition(arr, low, high);
quicksort(arr,low,pi-1);
quicksort(arr,pi+1,high);
}
}
 
int main()
{
int arr[SIZE],X[SIZE],Y[SIZE],Z[SIZE];
int n,i,j,c1,c2,c3;
printf("Enter size of array:");
scanf("%d",&n);
printf("\nEnter the %d array elements:", n);
for(i = 0; i < n; i++)
scanf("%d",&arr[i]);
count = 0;
quicksort(arr,0,n-1);
printf("\nSorted array is ");
for(i = 0; i < n;i++)
printf("%d ", arr[i]);
printf("\nThe basic operation executes %d times\n",count);
printf("\nSIZE\tASC\tDESC\tRANDOM\n");
for( i = 16; i < SIZE; i *= 2)
{
for( j = 0; j < i; j++)
{
X[j] = j;
Y[j] = i-j-1;
Z[j] = rand() % i;
}
count = 0;
quicksort(X, 0, i-1);
c1 = count;
count = 0;
quicksort(Y, 0, i-1);
c2 = count;
count = 0;
quicksort(Z, 0, i-1);
c3 = count;
printf("%d\t%d\t%d\t%d\n",i,c1,c2,c3);
}
return 0;
}
9)
 
#include <stdio.h>
#include <stdlib.h>
#define SIZE 1000

int count = 0;

void heapify(int a[], int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && a[l] > a[largest]) {
        largest = l;
    }

    if (r < n && a[r] > a[largest]) {
        largest = r;
    }

    if (largest != i) {
        int temp = a[i];
        a[i] = a[largest];
        a[largest] = temp;
        count++;

        heapify(a, n, largest);
    }
}

void heapSort(int a[], int n) {
    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(a, n, i);
    }

    for (int i = n - 1; i > 0; i--) {
        int temp = a[0];
        a[0] = a[i];
        a[i] = temp;
        count++;

        heapify(a, i, 0);
    }
}

int main() {
    int a[SIZE], x[SIZE], y[SIZE], z[SIZE], n;
    printf("Enter size of array: ");
    scanf("%d", &n);

    printf("Enter elements: ");
    for (int i = 0; i < n; i++) scanf("%d", &a[i]);

    heapSort(a, n);
    printf("Sorted array: ");
    for (int i = 0; i < n; i++) printf("%d ", a[i]);
    printf("\nBasic operations = %d\n", count);

    printf("\nSize\tASC\tDESC\tRAND\n");
    for (int i = 16; i <= SIZE / 4; i *= 2) {
        for (int j = 0; j < i; j++) {
            x[j] = j;
            y[j] = i - j - 1;
            z[j] = rand() % i;
        }

        count = 0; heapSort(x, i); int c1 = count;

        count = 0; heapSort(y, i); int c2 = count;

        count = 0; heapSort(z, i); int c3 = count;

        printf("%d\t%d\t%d\t%d\n", i, c1, c2, c3);
    }

    return 0;
}



 
10)
#include <stdio.h>
 
void bfs(int a[][10], int n, int v[], int source) {
int q[10], f = 0, r = 0;
v[source] = 1;
q[r] = source;
 
printf("Dequeue Order: ");
 
while (f <= r) {
int node = q[f++];
printf("%d ", node); // Printing the dequeue order
 
for (int i = 1; i <= n; i++) {
if (!v[i] && a[node][i] == 1) {
q[++r] = i;
v[i] = 1;
}
}
}
printf("\n");
}
 
int main() {
int n, a[10][10], v[10] = {0}, count = 0;
printf("Enter the number of nodes: ");
scanf("%d", &n);
 
printf("Enter the adjacency matrix:\n");
for (int i = 1; i <= n; i++)
for (int j = 1; j <= n; j++)
scanf("%d", &a[i][j]);
 
for (int i = 1; i <= n; i++) {
if (!v[i]) {
bfs(a, n, v, i);
count++;
}
}
 
if (count == 1)
printf("The graph is connected\n");
else
printf("The graph is not connected and has %d components\n", count);
 
return 0;
}
 
11)
#include <stdio.h>
 
#define INF 99999
 
int min(int a, int b) {
return (a < b) ? a : b;
}
 
void floydWarshall(int Distance[10][10], int n) {
for (int k = 0; k < n; k++) {
for (int i = 0; i < n; i++) {
for (int j = 0; j < n; j++) {
Distance[i][j] = min(Distance[i][j], Distance[i][k] + Distance[k][j]);
}
}
}
 
printf("Shortest distances between every pair of vertices:\n");
for (int i = 0; i < n; i++) {
for (int j = 0; j < n; j++) {
if (Distance[i][j] == INF) {
printf("%7s", "INF");
} else {
printf("%7d", Distance[i][j]);
}
}
printf("\n");
}
}
 
int main() {
int n, Distance[10][10];
 
printf("Enter the number of vertices: ");
scanf("%d", &n);
 
printf("Enter the adjacency matrix (use 99999 for infinity):\n");
for (int i = 0; i < n; i++) {
for (int j = 0; j < n; j++) {
scanf("%d", &Distance[i][j]);
}
}
 
floydWarshall(Distance, n);
 
return 0;
}
 
12)
 
#include <stdio.h>
 
#define INF 999
 
void prims(int n, int cost[10][10]) {
int visited[10] = {0}, mincost = 0, e = 0;
visited[1] = 1;
 
while (e < n - 1) {
int min = INF, u = -1, v = -1;
for (int i = 1; i <= n; i++) {
if (visited[i]) {
for (int j = 1; j <= n; j++) {
if (!visited[j] && cost[i][j] < min) {
min = cost[i][j];
u = i;
v = j;
}
}
}
}
printf("\nEdge %d: (%d %d) cost: %d", ++e, u, v, min);
mincost += min;
visited[v] = 1;
}
 
printf("\nTotal cost = %d\n", mincost);
}
 
int main() {
int n, cost[10][10];
printf("Enter number of nodes: ");
scanf("%d", &n);
printf("Enter adjacency matrix:\n");
for (int i = 1; i <= n; i++)
for (int j = 1; j <= n; j++) {
scanf("%d", &cost[i][j]);
if (cost[i][j] == 0) cost[i][j] = INF;
}
prims(n, cost);
return 0;
}
 
