#define EIGEN_USE_BLAS

#include "clients/nrt/TransientSliceNRT.hpp"

#include  "MaxNonRealTimeBase.hpp"

//#include "version.h"


//#include "algorithms/STFT.hpp"

#include "ext_obex.h"


#include <vector>
#include <array>
#include <algorithm>


namespace fluid {
  namespace wrapper {
class TransientSliceNRTMax: public fluid::max::MaxNonRealTimeBase
{
public:
  static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
  {
    addMethod<TransientSliceNRTMax,&TransientSliceNRTMax::process>(c, "process");
    makeAttributes<client::TransientSliceNRT,TransientSliceNRTMax>(c,true);
  }

  TransientSliceNRTMax(t_symbol *s, long argc, t_atom *argv)
  {
    attr_args_process(*this, argc, argv);
    mOutlets.push_back((t_object*)bangout(this));
  }
  
  ~TransientSliceNRTMax()
  {
    for(auto&& a: mOutlets)
      object_free(a);
  }
  
  void process(t_symbol *s, long ac, t_atom *av)
  {

    deferMethod<TransientSliceNRTMax,&TransientSliceNRTMax::do_process>(s, ac, av);
  }
  
  std::vector<client::Instance>& getParams()
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
          while(getParams()[paramIdx].getDescriptor().getType() != client::Type::kBuffer)
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
          while(getParams()[paramIdx].getDescriptor().getType() != client::Type::kLong
                && getParams()[paramIdx].getDescriptor().getType() != client::Type::kFloat)
          {
            if(++paramIdx >= getParams().size())
            {
              object_error(*this, "Could not parse arguments. Ran in trouble at argument %ld",i);
              return;
            }
          }
          
          client::Instance& p = getParams()[paramIdx++];
          
          if(p.getDescriptor().getType() == client::Type::kLong)
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
      if(p.getDescriptor().getType() == client::Type::kBuffer && p.getBuffer())
        (static_cast<max::MaxBufferAdaptor*>(p.getBuffer()))->update();
    
    bool parametersOk;
    client::TransientSliceNRT::ProcessModel processModel;
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
  client::TransientSliceNRT trans;
  std::vector<t_object*> mOutlets;
};
}
}
void ext_main(void *r)
{
  fluid::wrapper::TransientSliceNRTMax::makeClass<fluid::wrapper::TransientSliceNRTMax>(CLASS_BOX, "fluid.buftransientslice~");
}


