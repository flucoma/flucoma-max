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


#include <ext.h>
#include <ext_atomic.h>
#include <ext_dictobj.h>
#include <ext_obex.h>
#include <ext_obex_util.h>

#include "../../MaxBufferAdaptor.hpp"
#include <algorithm>
#include <vector>

namespace fluid {
namespace client {
namespace buffertolist {

using Buffer = std::unique_ptr<MaxBufferAdaptor>;

struct FluidBufToList
{
  t_object      obj;
  index         axis{0};
  index         maxSize{256};
  index         startChannel{0};
  index         startFrame{0};
  index         size{-1};
  Buffer        source;
  void*         outlet;
  void*         proxy;
  long          in;
  std::vector<t_atom> output;
};

t_class* FluidBufToListClass{nullptr};

void* FluidBufToList_new(t_symbol* s, long argc, t_atom* argv);
void  FluidBufToList_free(FluidBufToList* x);
void FluidBufToList_assist(FluidBufToList* x, void* b, long m, long a, char* s);
void FluidBufToList_process(FluidBufToList* x);

void FluidBufToList_bang(FluidBufToList* x);


t_max_err FluidBufToList_setSource(FluidBufToList* x, t_object* attr, long argc,
                                t_atom* argv);
t_max_err FluidBufToList_getSource(FluidBufToList* x, t_object* attr, long* argc,
                                t_atom** argv);
t_max_err FluidBufToList_notify(FluidBufToList* x, t_symbol* s, t_symbol* msg,
                                void* sender, void* data);

void FluidBufToList_dblclick(FluidBufToList* x);

void main()
{

  FluidBufToListClass =
      class_new("fluid.buf2list", (method) FluidBufToList_new,
                (method) FluidBufToList_free, (long) sizeof(FluidBufToList), 0L,
                A_GIMME, 0);

  class_addmethod(FluidBufToListClass, (method) FluidBufToList_bang, "bang", 0);

  class_addmethod(FluidBufToListClass, (method) FluidBufToList_notify, "notify",
                  A_CANT, 0);
  class_addmethod(FluidBufToListClass, (method) FluidBufToList_process, "list",
                  A_GIMME, 0);
  class_addmethod(FluidBufToListClass, (method) FluidBufToList_assist, "assist",
                  A_CANT, 0);

  class_addmethod(FluidBufToListClass, (method) FluidBufToList_dblclick,
                  "dblclick", A_CANT, 0);

  CLASS_ATTR_SYM(FluidBufToListClass, "source", 0, FluidBufToList, source);
  CLASS_ATTR_LABEL(FluidBufToListClass, "source", 0, "Source   Buffer");
  CLASS_ATTR_ACCESSORS(FluidBufToListClass, "source", FluidBufToList_getSource,
                       FluidBufToList_setSource);

  CLASS_ATTR_LONG(FluidBufToListClass, "axis", 0, FluidBufToList, axis);
  CLASS_ATTR_LABEL(FluidBufToListClass, "axis", 0,
                   "Read Frame-wise or Channel-wise");
  CLASS_ATTR_FILTER_CLIP(FluidBufToListClass, "axis", 0, 1);

  CLASS_ATTR_LONG(FluidBufToListClass, "startframe", 0, FluidBufToList,
                  startFrame);
  CLASS_ATTR_FILTER_MIN(FluidBufToListClass, "startframe", 0);

  CLASS_ATTR_LONG(FluidBufToListClass, "startchan", 0, FluidBufToList,
                  startChannel);
  CLASS_ATTR_FILTER_MIN(FluidBufToListClass, "startchan", 0);

  CLASS_ATTR_LONG(FluidBufToListClass, "size", 0, FluidBufToList,
                  size);
  
//  CLASS_ATTR_FILTER_MIN(FluidBufToListClass, "size", -1);

  class_dumpout_wrap(FluidBufToListClass);
  class_register(CLASS_BOX, FluidBufToListClass);
}

void* FluidBufToList_new(t_symbol*, long argc, t_atom* argv)
{

  FluidBufToList* x = (FluidBufToList*) object_alloc(FluidBufToListClass);

  x->outlet = listout(x);
  x->proxy = proxy_new((t_object *)x, 1, &x->in);
  long argCount = attr_args_offset(argc, argv);
  
  x->maxSize = argCount ?  std::min(atom_getlong(argv),t_atom_long(32767)) : 256;
    
  x->output.reserve(x->maxSize);

  attr_args_process(x, argc - argCount, argv + argCount);
  x->size = -1;
  return x;
}

t_max_err FluidBufToList_setSource(FluidBufToList* x, t_object* /*attr*/,
                                long argc, t_atom* argv)
{
  if (argc)
  {
    t_symbol* s = atom_getsym(argv);
    if (s == gensym(""))
    {
      x->source.reset(nullptr);
    }
    else
    {
      x->source.reset(new MaxBufferAdaptor((t_object*) x, s));
    }
  }
  
  if(proxy_getinlet((t_object*) x) == 0) FluidBufToList_process(x);
  
  return MAX_ERR_NONE;
}

void FluidBufToList_bang(FluidBufToList* x){
  FluidBufToList_process(x);
}

t_max_err FluidBufToList_getSource(FluidBufToList* x, t_object* /*attr*/,
                                long* argc, t_atom** argv)
{
  char alloc;
  atom_alloc(argc, argv, &alloc);

  if (x->source) atom_setsym(*argv, x->source->name());

  return MAX_ERR_NONE;
}

void FluidBufToList_free(FluidBufToList* x)
{
  if (x->proxy) object_free(x->proxy);
}

void FluidBufToList_process(FluidBufToList* x)
{
  if (x->source)
  {
    

//    if (!buf.exists())
//    {
//      object_error((t_object*) x, "Buffer %s not found", x->source->name());
//      return;
//    }
//
//    if (!buf.valid()) return;
//
    index nFrames = x->axis == 0 ? x->size : 1;
    index nChans = x->axis ==  0 ?  1 : x->size ;
    
    auto r = bufferRangeCheck(x->source.get(), x->startFrame, nFrames, x->startChannel, nChans);
    if(r.status() == Result::Status::kError)
    {
      object_error((t_object*)x,r.message().c_str());
      return;
    }
    
    
    auto buf = MaxBufferAdaptor::Access(x->source.get());
    index count = x->axis == 0
                      ? std::min(x->maxSize, nFrames)
                      : std::min(x->maxSize, nChans);


    auto frames =
        buf.allFrames()(Slice(x->startChannel, x->axis == 0 ? 1 : count),
                        Slice(x->startFrame, x->axis == 0 ? count : 1));

      std::for_each(frames.begin(),frames.end(),[x, n=0](const float& f) mutable -> void {
        atom_setfloat(&x->output[n++],f);
      });
    
      outlet_list(x->outlet, nullptr, count, x->output.data());
  }
}

void FluidBufToList_assist(FluidBufToList*, void*, long io, long, char* s)
{
  switch (io)
  {
  case 1: strncpy_zero(s, "(list) input", 512); break;
  case 2: strncpy_zero(s, "(list) buffer output", 512); break;
  }
}

t_max_err FluidBufToList_notify(FluidBufToList* x, t_symbol* s, t_symbol* msg,
                                void* sender, void* data)
{
  if (x->source) { x->source->notify(s, msg, sender, data); }
  return MAX_ERR_NONE;
}

void FluidBufToList_dblclick(FluidBufToList* x)
{
  if (x->source) x->source->view();
}

} // namespace buffertolist
} // namespace client
} // namespace fluid
