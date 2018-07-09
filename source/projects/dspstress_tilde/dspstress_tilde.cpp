/**
 @file
 dspstress~ - very simple msp object that does nothing except eat up a specified % of processor time

 updated 6/5/09 rbs: initial

 @ingroup	examples
 */

#include "ext.h"
#include "z_dsp.h"

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


void dspstress_dsp64(t_dspstress* x, t_object* dsp64, short *count, double samplerate, long maxvectorsize, long flags) {
	x->svtime_ms = maxvectorsize / samplerate * 1000.0;
    object_method(dsp64, gensym("dsp_add64"), x, dspstress_perform64, 0, NULL);
}


void dspstress_assist(t_dspstress *x, void *b, long m, long a, char *s)
{
    if (m == ASSIST_INLET) {
        switch (a) {
            case 0:
                strcpy(s,"Specify cpu usage % here");
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
