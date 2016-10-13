#include <stdio.h>
#include <math.h>

int main()
{
int a[8] ={1,0,1,0,1,0,1,0};
int b[8] ={0,0,1,1,0,0,1,1};
int c[8] ={0,0,0,0,0,0,0,0};
int j;

hls_run_kernel("add",c,8);
	printf(c[j]);
	return 0;
}
