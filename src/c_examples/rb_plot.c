/** \file rb_plot.c 
\brief Example: fetch ADC samples in a ring buffer, save to file and view by GnuPlot. 
 
This file contains an example on how to use the ring buffer mode of 
libpruio. A fixed step mask of AIN-0 (P9_39) get configured 
for maximum speed, sampled in to the ring buffer and from there saved 
to a files and viewed by GnuPlot
 
Licence: GPLv3 
 
Copyright 2016 by Axel Hülsmann (axhuelsmann[at]analog-photonics[dot]com)

Thanks:		for libpruio: Thomas{ dOt ]Freiherr[ At ]gmx[ DoT }net 
		for C code translation: Nils Kohrs (nils.kohrs [at] gmail.com) 

Prepare: 	sudo su      						(always)
		apt-get install gnuplot					(once)
		echo BB-BONE-PRU-01 > /sys/devices/bone_capemgr.9/slots (after reboot)
 
Compile by: 	gcc -Wall -o rb_plot rb_plot.c -lpruio 			(-lprussdrv)
*/ 
 
#include "stdio.h" 
#include "../c_wrapper/pruio.h" 
 
int main(int argc, char **argv) 
{ 
  const uint16  Act = PRUIO_DEF_ACTIVE; // activation mode
  const uint8    Av = 0;	// avaraging for default steps
  const uint32  OpD = 0;	// open delay for default steps (default 0x98, max 0x3FFFF)
  const uint8   SaD = 0;	// sample delay for default steps (defaults to 0)
  const uint8   Stp = 9;	// step index (0=step 0=>charge step, 1=step 1 (=> AIN-0 by default), ...., 17 = idle step)
  const uint8   ChN = 0;	// Channel Number to scan (0 = AIN-0, 1= AIN-1, ....)
  const uint16  Mds = 4;	// modus for output (default to 4 = 16 bit)
  const uint32 samp = 500;      // number of samples in the files (per step) 
        uint32 mask = 1 << Stp;	// mask for active steps (default to all 8 channels active in steps 1 to 8)
  const uint32  tmr = 10000;	// 1ms! sampling rate in ns (10000 -> 100 kHz) 
  	uint32    k = 0; 	// counter for array
  	uint16 array[samp]; 	// array for text file

  pruIo *io = pruio_new(Act, Av, OpD, SaD); // create new driver
  if (io->Errr){ printf("constructor failed (%s)\n", io->Errr); return 1;} 
 
  if (pruio_adc_setStep(io, Stp, ChN, Av, SaD, OpD)) printf("configuration failed: (%s)\n", io->Errr); 

  if (pruio_config(io, samp, mask, tmr, Mds)) printf("config failed (%s)\n", io->Errr);
 
  if (pruio_rb_start(io))printf("rb_start failed (%s)\n", io->Errr); // start measurement
 
  uint16 *p = io->Adc->Value;  // pointer to start of ring buffer. 

  FILE *plotfile = fopen("output.dat", "w+"); 

  	for( k = 0; k < samp; k++) {
		array[k] = *(p + k); // reading ring buffer
		fprintf(plotfile , "%i \n", array[k]);}

  fclose(plotfile);
  pruio_destroy(io); 

  // view adc in GnuPlot using pipes
  FILE *gnuplotPipe = popen("gnuplot -persistent" , "w");
  fprintf(gnuplotPipe, "plot 'output.dat'\n");
  pclose(gnuplotPipe);
  return 0; 
} 
