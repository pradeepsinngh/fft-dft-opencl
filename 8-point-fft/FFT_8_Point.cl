//8 point fft kernel code 

# include <clc.h>


__kernel __attribute__((reqd_work_group_size(1,2,2))) void fft(__global float2* Y,int N,__global float2* Y3)
{ int i;
	float2 twiddleFactors1[8];
	float2 twiddleFactors2[8];
	float2 Y1[16],Y2[16];
	
	for( i= 0;i<N/2;i++)
	{
		Y1[2*i] = Y[2*i] + Y[2*i+1];
		Y1[2*i+1] = Y[2*i] - Y[2*i+1];

	}

	
	   int j = get_global_id(1);
         Y1[2*j] = Y[2*j] + Y[2*j+1];
		 Y1[2*j+1] = Y[2*j] - Y[2*j+1];
                
		 float param1 = - 3.14159265359f * 2 * (2*j) / (float)N;
		 float c1, s1 = sincos(param1, &c1);
		        
		   twiddleFactors1[2*j] = (float2)(c1, -s1);
		   twiddleFactors2[2*j] = (float2)(s1, c1);
		 
		 float param2 = - 3.14159265359f * 2 * (2*j+1) / (float)N;
         float c2, s2 = sincos(param2, &c2);
		        
           twiddleFactors1[2*j+1] = (float2)(c2, -s2);
		   twiddleFactors2[2*j+1] = (float2)(s2, c2);



    for ( i=0; i<2; i++)
    
    {
    	{
      Y2[j+i*N/2] = Y1[j+(i*4)] + (float2)(dot(Y1[j+(i*4)+2],twiddleFactors1[2*j]),dot(Y1[j+(i*4)+2],twiddleFactors2[2*j]));
		 Y2[j+2+i*N/2] = Y1[j+(i*4)] - (float2)(dot(Y1[j+(i*4)+2],twiddleFactors1[2*j]),dot(Y1[j+(i*4)+2],twiddleFactors2[2*j]));	 }


}

   {
	int m = get_global_id(2);
for ( i=0; i<2; i++)
{
	 {
		 Y3[m+i*2] = Y2[m+i*2] + (float2)(dot(Y2[m+i*2+4],twiddleFactors1[m+i*2]),dot(Y2[m+i*2+4],twiddleFactors2[m+i*2]));
		 Y3[m+i*2+4] = Y2[m+i*2] - (float2)(dot(Y2[m+i*2+4],twiddleFactors1[m+i*2]),dot(Y2[m+i*2+4],twiddleFactors2[m+i*2]));
		 }


}


}
}
