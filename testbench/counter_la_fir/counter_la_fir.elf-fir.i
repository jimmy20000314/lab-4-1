# 0 "fir.c"
# 1 "/home/jimmy/caravel-soc_fpga-lab/lab-exmem_fir/testbench/counter_la_fir//"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "fir.c"
# 1 "fir.h" 1





int taps[11] = {0,-10,-9,23,56,63,56,23,-9,-10,0};
int inputbuffer[11];
int inputsignal[11] = {1,2,3,4,5,6,7,8,9,10,11};
int outputsignal[11];
# 2 "fir.c" 2

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {

 int j;
 for(j=0; j<11; j++)
  {
   inputbuffer[j] = 0;
   outputsignal[j] = 0;
  }
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
 initfir();

 int i,j;
 int temp;

 for(i=0; i<11; i++)
 {
  temp = 0;
  for(j=0; j<11; j++)
  {
   if(i>=j)
   {
    inputbuffer[11 -j-1]=inputsignal[i-j];
   }
   temp += taps[j]*inputbuffer[11 -j-1];
  }
  outputsignal[i] = temp;
 }

 return outputsignal;
}
