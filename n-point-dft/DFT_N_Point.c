
//N point Dft host code

#include<stdio.h>
#define len 64   // denotes value of N point
#include <math.h>
#define PI 3.141593f
void dfti(float *in, float *out,int length)
{
	int i,k;
	for (i = 0; i < length; i++)
	{

		float out_real = 0, out_imag = 0;
		float param = (-2 * i) * PI / (float)length;

		for (k = 0; k < length; k++) {
			float value_real = in[k * 2], value_imag = in[k * 2 + 1];
			float arg = k * param;
			float c = cos(arg);
			float s = sin(arg);

			out_real += value_real * c - value_imag * s;
			out_imag += value_real * s + value_imag * c;
		}

			out[i * 2] = out_real;
			out[i * 2 + 1] = out_imag;

	}
}

int main()
{

    float error = 0.2f;
 	int i,length=64,sign=1;
	float x[2*length],y[2*length],output[2*length];

	for(int k=0;k<length;k++)
	{
		 x[2*k] = 1.0f;//(float)k;
		 x[2*k+1] = 0.0f;//(float)k;

		 y[2*k] = 0.0f;
		 y[2*k+1] = 0.0f;

	}

	hls_run_kernel("dft",x,2*len,y,2*len,length,1,sign,1);
	dfti(x,output,length);

	for(i=0;i<2*length;i++)
	printf("%f\t%f\n",y[i],output[i]);

	for(int j=0;j<2*length;j++)
	{
	if(abs(y[j]-output[j])>error)
	{printf("not matching %d \n",j);}
	else
	printf(" matching\n");
}
	return 0;
}
