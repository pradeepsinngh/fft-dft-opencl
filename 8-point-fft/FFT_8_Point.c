
//8 point fft host code
#include<stdio.h>
#include <math.h>

int main()
{


 	int i,length=8,sign=1;
 	float twid[16]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};//output
	float y[16]={1.0f,4.0f,5.0f,2.0f,3.0f,7.0f,7.0f,8.0f,2.0f,1.0f,6.0f,4.0f,4.0f,9.0f,8.0f,5.0f};//input



	hls_run_kernel("fft",y,16,length,1,twid,16);
	for(i=0;i<2*length;i++)
		printf("%f /t %f \n",y[i],twid[i]);
	return 0;
}
