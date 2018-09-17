#include "clients/nrt/HPSS.hpp"
#include "MaxNonRealTimeBase.hpp"
#include "ext_obex.h"
#include <vector>
#include <array>
#include <algorithm>

namespace fluid {
class HPSS_NRT: public fluid::max::MaxNonRealTimeBase
{
public:
  static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
  {
    addMethod<HPSS_NRT,&HPSS_NRT::process>(c, "process");
    makeAttributes<hpss::HPSSClient,HPSS_NRT>(c,true);
  }

  HPSS_NRT(t_symbol *s, long argc, t_atom *argv)
  {
    attr_args_process(*this, argc, argv);
    mOutlets.push_back((t_object*)bangout(this));
  }
  
  ~HPSS_NRT()
  {
    for(auto&& a: mOutlets)
      object_free(a);
  }
  
  void process(t_symbol *s, long ac, t_atom *av)
  {
    deferMethod<HPSS_NRT,&HPSS_NRT::do_process>(s, ac, av);
  }
  
  std::vector<parameter::Instance>& getParams()
  {
    return bufferHPSS.getParams();
  }

private:
  
  void do_process(t_symbol *s, long ac, t_atom *av)
  {
    
    size_t paramIdx = 0;
    //This is pretty low fi. Really, params should know if they're optional, and we should die as soon as it becomes clear
    //that things are wonky.
    for(size_t i = 0; i < ac; ++i)
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
    
    bool parametersOk;
    hpss::HPSSClient::ProcessModel processModel;
    std::string whatHappened;//this will give us a message to pass back if param check fails
    std::tie(parametersOk,whatHappened,processModel) = bufferHPSS.sanityCheck();
    if(!parametersOk)
    {
      object_error(*this, whatHappened.c_str());
      return;
    }
    
    bufferHPSS.process(processModel);
    
    for(auto&& p: getParams())
    {
      if(p.getDescriptor().instantiation())
        p.reset();
    }
    
    outlet_bang(mOutlets[0]);
  }
  hpss::HPSSClient bufferHPSS;
  std::vector<t_object*> mOutlets;
};
}
void ext_main(void *r)
{
  fluid::HPSS_NRT::makeClass<fluid::HPSS_NRT>(CLASS_BOX, "fluid.bufhpss~");
}


