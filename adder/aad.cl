# include <clc.h>

__kernel __attribute__((reqd_work_group_size(1,2,2))) void add(__global int* a,int *b,__global int* c)
{

int i,j;
int sum,carry=0;

int i = get_global_id(0);

for(i=7;i>=0;i--)
{
    if(a[i]==b[i]==1)
    {
      sum=0;
      carry=1;
    }
    else
    {
      if(a[i]==b[i]==0)
        {
          sum=0;
          carry=0;
        }
      else
       {
          sum=1;
          carry=0;
        }
    }
    
    if(sum==carry==1)
    {
      sum=0;
      carry=1;
    }
    else
    {
      if(sum==carry==0)
       {
         sum=0;
         carry=0;
        }
        else
        {
           sum=1;
           carry=0;
        }
    }

c[j]=sum;
j--;
}

printf("\nthe sum of the two binary number is->");
for(j=8;j>=0;j--)

{
printf("%d",c[j]);
}

}

