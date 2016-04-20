/**
 @file
 dspstress~ - very simple msp object that does nothing except eat up a specified % of processor time

 updated 6/5/09 rbs: initial

 @ingroup	examples
 */

#include "c74_msp.h"

using namespace c74::max;

static t_class* this_class = nullptr;


struct t_dspstress {
	t_pxobject	obj;
	double		cpuusagetarget;	// how much cpu to burn (0 - 100)
	double		svtime_ms;		// how long one signal vector takes in ms
};


void dspstress_float(t_dspstress* self, double f) {
	self->cpuusagetarget = f;
}


void dspstress_int(t_dspstress* self, long n) {
	dspstress_float(self, (double)n);
}


void dspstress_perform64(t_dspstress* self, t_object* dsp64, double** ins, long numins, double** outs, long numouts, long sampleframes, long flags, void* userparam) {
	double			spintime = self->svtime_ms * self->cpuusagetarget / 100.0;
	double			intime = systimer_gettime();
	double			outtime = intime + spintime;
	unsigned long	spincounter = 0;

	while (systimer_gettime() < outtime)
		spincounter++;		// tra la la
}


void dspstress_dsp64(t_dspstress* self, t_object* dsp64, short *count, double samplerate, long maxvectorsize, long flags) {
	self->svtime_ms = maxvectorsize / samplerate * 1000.0;
	object_method_direct(void, (t_object*, t_object*, t_perfroutine64, long, void*),
						 dsp64, gensym("dsp_add64"), (t_object*)self, (t_perfroutine64)dspstress_perform64, 0, NULL);
}


void dspstress_assist(t_dspstress* self, void* unused, t_assist_function io, long index, char* string_dest) {
	if (io == ASSIST_INLET) {
		switch (index) {
			case 0:
				strncpy(string_dest, "Specify cpu usage % here", ASSIST_STRING_MAXSIZE);
				break;
		}
	}
}


void* dspstress_new(double val) {
	t_dspstress* x = (t_dspstress*)object_alloc(this_class);
	dsp_setup((t_pxobject*)x, 1);
	dspstress_float(x, val);
	return x;
}


void ext_main(void* r) {
	this_class = class_new("dspstress~", (method)dspstress_new, (method)dsp_free, sizeof(t_dspstress), 0, A_DEFFLOAT, 0);
	
	class_addmethod(this_class, (method)dspstress_dsp64, "dsp64", A_CANT, 0);
	class_addmethod(this_class, (method)dspstress_float, "float", A_FLOAT, 0);
	class_addmethod(this_class, (method)dspstress_int, "int", A_LONG, 0);
	class_addmethod(this_class, (method)dspstress_assist,"assist",A_CANT,0);
	class_dspinit(this_class);
	
	class_register(CLASS_BOX, this_class);
}
