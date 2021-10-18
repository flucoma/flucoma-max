/*
Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
Copyright 2017-2019 University of Huddersfield.
Licensed under the BSD-3 License.
See license.md file in the project root for full license information.
This project has received funding from the European Research Council (ERC)
under the European Union’s Horizon 2020 research and innovation programme
(grant agreement No 725899).
*/

#pragma once

#include <algorithm>
#include <ext.h>
#include <ext_atomic.h>
#include <ext_dictobj.h>
#include <ext_obex.h>
#include <ext_obex_util.h>

#include "../../MaxBufferAdaptor.hpp"
#include <vector>

namespace fluid {
namespace client {
namespace buffertolist {

using Buffer = std::unique_ptr<MaxBufferAdaptor>;

struct FluidListToBuf
{
  t_object      obj;
  t_object*     defaultOut;
  t_buffer_ref* outputRef;
  t_symbol*     defaultOutName{nullptr};
  t_atom        outName;
  index         axis{0};
  index         canResize;
  index         startChannel{0};
  index         startFrame{0};
  Buffer        output;
  void*         outlet;
};

t_symbol* bufferSym {nullptr};

t_class* FluidListToBufClass{nullptr};

void* FluidListToBuf_new(t_symbol* s, long argc, t_atom* argv);
void  FluidListToBuf_free(FluidListToBuf* x);
void FluidListToBuf_assist(FluidListToBuf* x, void* b, long m, long a, char* s);
void FluidListToBuf_list(FluidListToBuf* x, t_symbol* /*s*/, long argc,
                         t_atom* argv);
void FluidListToBuf_float(FluidListToBuf* x, double floatin);
void FluidListToBuf_int(FluidListToBuf* x, long intin);

t_max_err FluidListToBuf_setOut(FluidListToBuf* x, t_object* attr, long argc,
                                t_atom* argv);
t_max_err FluidListToBuf_getOut(FluidListToBuf* x, t_object* attr, long* argc,
                                t_atom** argv);
t_max_err FluidListToBuf_notify(FluidListToBuf* x, t_symbol* s, t_symbol* msg,
                                void* sender, void* data);

void FluidListToBuf_dblclick(FluidListToBuf* x);

void main()
{

  FluidListToBufClass =
      class_new("fluid.list2buf", (method) FluidListToBuf_new,
                (method) FluidListToBuf_free, (long) sizeof(FluidListToBuf), 0L,
                A_GIMME, 0);

  class_addmethod(FluidListToBufClass, (method) FluidListToBuf_notify, "notify",
                  A_CANT, 0);
  class_addmethod(FluidListToBufClass, (method) FluidListToBuf_list, "list",
                  A_GIMME, 0);
  class_addmethod(FluidListToBufClass, (method) FluidListToBuf_float,
                "float", A_FLOAT, 0);
  class_addmethod(FluidListToBufClass, (method) FluidListToBuf_int,
                              "int", A_LONG, 0);

  class_addmethod(FluidListToBufClass, (method) FluidListToBuf_assist, "assist",
                  A_CANT, 0);

  class_addmethod(FluidListToBufClass, (method) FluidListToBuf_dblclick,
                  "dblclick", A_CANT, 0);

  CLASS_ATTR_SYM(FluidListToBufClass, "destination", 0, FluidListToBuf, outName);
  CLASS_ATTR_LABEL(FluidListToBufClass, "destination", 0, "Output Buffer");
  CLASS_ATTR_ACCESSORS(FluidListToBufClass, "destination", FluidListToBuf_getOut,
                       FluidListToBuf_setOut);

  CLASS_ATTR_LONG(FluidListToBufClass, "axis", 0, FluidListToBuf, axis);
  CLASS_ATTR_LABEL(FluidListToBufClass, "axis", 0,
                   "Write Frame-wise or Channel-wise");
  CLASS_ATTR_FILTER_CLIP(FluidListToBufClass, "axis", 0, 1);

  CLASS_ATTR_LONG(FluidListToBufClass, "autosize", 0, FluidListToBuf, canResize);
  CLASS_ATTR_STYLE_LABEL(FluidListToBufClass, "autosize", 0, "onoff",
                         "Enable resizing (will defer)");

  CLASS_ATTR_LONG(FluidListToBufClass, "startframe", 0, FluidListToBuf,
                  startFrame);
  CLASS_ATTR_FILTER_MIN(FluidListToBufClass, "startframe", 0);

  CLASS_ATTR_LONG(FluidListToBufClass, "startchan", 0, FluidListToBuf,
                  startChannel);
  CLASS_ATTR_FILTER_MIN(FluidListToBufClass, "startchan", 0);

  class_register(CLASS_BOX, FluidListToBufClass);
  
  bufferSym = gensym("buffer");
  
}

void* FluidListToBuf_new(t_symbol*, long argc, t_atom* argv)
{

  FluidListToBuf* x = (FluidListToBuf*) object_alloc(FluidListToBufClass);

  x->outlet = listout(x);
  x->defaultOutName = symbol_unique();

  long argCount = attr_args_offset(argc, argv);

  t_atom bufferArgs;
  atom_setsym(&bufferArgs, x->defaultOutName);

  x->defaultOut = (t_object*) object_new_typed(CLASS_BOX, gensym("buffer~"), 1,
                                               &bufferArgs);
                                      
  x->output.reset(new MaxBufferAdaptor((t_object*) x, x->defaultOutName));
  atom_setsym(&x->outName, x->defaultOutName);
  {
  auto buf = MaxBufferAdaptor::Access(x->output.get());
  buf.resize(argCount > 0 ? atom_getlong(argv) : 0,
             argCount > 1 ? atom_getlong(argv + 1) : 0,
             x->output->sampleRate());
  }
  x->canResize = 1; 
  attr_args_process(x, argc - argCount, argv + argCount);  
  return x;
}

t_max_err FluidListToBuf_setOut(FluidListToBuf* x, t_object* /*attr*/,
                                long argc, t_atom* argv)
{
  if (argc)
  {
    t_symbol* s = atom_getsym(argv);
    if (s == gensym(""))
    {
      atom_setsym(&x->outName, x->defaultOutName);
      x->output.reset(new MaxBufferAdaptor((t_object*) x, x->defaultOutName));
    }
    else
    {
      atom_setsym(&x->outName, s);
      x->output.reset(new MaxBufferAdaptor((t_object*) x, s));
    }
  }
  return MAX_ERR_NONE;
}

t_max_err FluidListToBuf_getOut(FluidListToBuf* x, t_object* /*attr*/,
                                long* argc, t_atom** argv)
{
  char alloc;
  atom_alloc(argc, argv, &alloc);

  if (x->output) atom_setsym(*argv, x->output->name());

  return MAX_ERR_NONE;
}

void FluidListToBuf_free(FluidListToBuf* x)
{
  if (x->defaultOut) object_free(x->defaultOut);
}

void FluidListToBuf_float(FluidListToBuf* x, double floatin)
{
  t_atom floataslist;
  atom_setfloat(&floataslist, floatin);
  FluidListToBuf_list(x, nullptr, 1, &floataslist);
}

void FluidListToBuf_int(FluidListToBuf* x, long intin)
{
  t_atom intaslist;
  atom_setfloat(&intaslist, intin);
  FluidListToBuf_list(x, nullptr, 1, &intaslist);
}

void FluidListToBuf_list(FluidListToBuf* x, t_symbol* /*s*/, long argc,
                         t_atom* argv)
{
  if (x->output)
  {
    
    if (x->canResize && isr())
      object_warn((t_object*) x, "auto-sizing is enabled but object called from "
                                 "high-priority thread; use defer to resize");

    auto buf = MaxBufferAdaptor::Access(x->output.get());
    
    bool resizeAnyway {false};
    
    if((x->output->name() == x->defaultOutName) && !buf.valid())
    {
      if(isr())
      {
        object_error((t_object*) x, "Internal buffer %s not initialised and called on high-priority thread. Either initialise object with size, or call on main thread", x->output->name());
        return;
      } else resizeAnyway = true;
    }

    index count = x->axis == 0
                      ? std::min<index>(argc, buf.numFrames() - x->startFrame)
                      : std::min<index>(argc, buf.numChans() - x->startChannel);

    if (!buf.exists())
    {
      object_error((t_object*) x, "Buffer %s not found", x->output->name());
      return;
    }

    if (!isr() && (x->canResize || resizeAnyway))
    {
      bool needsResize = count < argc;

      if (needsResize && !buf.resize(x->axis == 0 ? x->startFrame + argc : 1,
                                     x->axis == 0 ? 1 : x->startChannel + argc,
                                     x->output->sampleRate())
                              .ok())
        object_error((t_object*) x, "Can't resize buffer %s", x->output->name());
      else
        count = argc;
    }

    if (!buf.valid())
    {
      object_error((t_object*) x, "Buffer %s not initialised", x->output->name());
      return;
    }

    auto frames =
        buf.allFrames()(Slice(x->startChannel, x->axis == 0 ? 1 : count),
                        Slice(x->startFrame, x->axis == 0 ? count : 1));

    std::transform(argv, argv + count, frames.begin(),
                   [](const atom& a) -> float { return atom_getfloat(&a); });

    outlet_anything(x->outlet, bufferSym, 1, &x->outName);
  }
}

void FluidListToBuf_assist(FluidListToBuf*, void*, long io, long, char* s)
{
  switch (io)
  {
  case 1: strncpy_zero(s, "(list) input", 512); break;
  case 2: strncpy_zero(s, "(list) buffer output", 512); break;
  }
}

t_max_err FluidListToBuf_notify(FluidListToBuf* x, t_symbol* s, t_symbol* msg,
                                void* sender, void* data)
{
  if (x->output) { x->output->notify(s, msg, sender, data); }
  return MAX_ERR_NONE;
}

void FluidListToBuf_dblclick(FluidListToBuf* x)
{
  if (x->output) x->output->view();
}

} // namespace buffertolist
} // namespace client
} // namespace fluid
