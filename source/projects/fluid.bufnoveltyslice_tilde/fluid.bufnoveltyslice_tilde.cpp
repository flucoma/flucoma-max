#define EIGEN_USE_BLAS

#include "clients/nrt/NoveltyClient.hpp"
#include  "MaxNonRealTimeBase.hpp"
#include "ext_obex.h"


#include <vector>
#include <array>
#include <algorithm>


namespace fluid {
  namespace segmentation {
class NoveltySliceNRTMax: public fluid::max::MaxNonRealTimeBase
{
public:
  static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
  {
    addMethod<NoveltySliceNRTMax,&NoveltySliceNRTMax::process>(c, "process");
    makeAttributes<NoveltyClient,NoveltySliceNRTMax>(c,true);
  }

  NoveltySliceNRTMax(t_symbol *s, long argc, t_atom *argv)
  {
    attr_args_process(*this, argc, argv);
    mOutlets.push_back((t_object*)bangout(this));
  }
  
  ~NoveltySliceNRTMax()
  {
    for(auto&& a: mOutlets)
      object_free(a);
  }
  
  void process(t_symbol *s, long ac, t_atom *av)
  {

    deferMethod<NoveltySliceNRTMax,&NoveltySliceNRTMax::do_process>(s, ac, av);
  }
  
  std::vector<parameter::Instance>& getParams()
  {
    return trans.getParams();
  }

private:
  
  void do_process(t_symbol *s, long ac, t_atom *av)
  {
    for(size_t i = 0, paramIdx = 0; i < ac; ++i)
    {
      switch(atom_gettype(av + i))
      {
        case A_SYM:
          while(getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Buffer)
          {
            if(++paramIdx >= getParams().size())
            {
              object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
              return;
            }
          }
          getParams()[paramIdx++].setBuffer(new max::MaxBufferAdaptor(*this, atom_getsym(av + i)));
          break;
        case A_FLOAT:
        case A_LONG:
        {
          while(getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Long
                && getParams()[paramIdx].getDescriptor().getType() != parameter::Type::Float)
          {
            if(++paramIdx >= getParams().size())
            {
              object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
              return;
            }
          }
          
          parameter::Instance& p = getParams()[paramIdx++];
          
          if(p.getDescriptor().getType() == parameter::Type::Long)
          {
            p.setLong(atom_getlong(av + i));
          }
          else
          {
            p.setFloat(atom_getfloat(av+i));
          }
          break;
        }
        default:
          assert(false && "I don't know how to interpret this state of affairs");
      }
    }
    
    for(auto&& p:getParams())
      if(p.getDescriptor().getType() == parameter::Type::Buffer && p.getBuffer())
        (static_cast<max::MaxBufferAdaptor*>(p.getBuffer()))->update();
    
    bool parametersOk;
    NoveltyClient::ProcessModel processModel;
    std::string whatHappened;//this will give us a message to pass back if param check fails
    std::tie(parametersOk,whatHappened,processModel) = trans.sanityCheck();
    if(!parametersOk)
    {
      object_error(*this, whatHappened.c_str());
      return;
    }
    trans.process(processModel);
    
    for(auto&& p: getParams())
    {
      if(p.getDescriptor().instantiation())
        p.reset();
    }
    
    outlet_bang(mOutlets[0]);
  }
  NoveltyClient trans;
  std::vector<t_object*> mOutlets;
};
}
}
void ext_main(void *r)
{
  fluid::segmentation::NoveltySliceNRTMax::makeClass<fluid::segmentation::NoveltySliceNRTMax>(CLASS_BOX, "fluid.bufnoveltyslice~");
}


