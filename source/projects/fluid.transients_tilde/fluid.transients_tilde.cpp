#define EIGEN_USE_BLAS

#include "clients/nrt/TransientNRTClient.hpp"

#include  "MaxNonRealTimeBase.hpp"

//#include "version.h"


//#include "algorithms/STFT.hpp"

#include "ext_obex.h"


#include <vector>
#include <array>
#include <algorithm>


namespace fluid {
class TransientMax: public fluid::max::MaxNonRealTimeBase
{
public:
  static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
  {
    addMethod<TransientMax,&TransientMax::process>(c, "process");
    makeAttributes<str::TransientNRTClient,TransientMax>(c);
  }

  TransientMax(t_symbol *s, long argc, t_atom *argv)
  {
    attr_args_process(*this, argc, argv);
    mOutlets.push_back((t_object*)bangout(this));
  }
  
  ~TransientMax()
  {
    for(auto&& a: mOutlets)
      object_free(a);
  }
  
  

  
  void process(t_symbol *s, long ac, t_atom *av)
  {
    
    if(atom_gettype(av) == A_SYM)
      trans.getParams()[0].setBuffer( new max::MaxBufferAdaptor(*this, atom_getsym(av)));

    
    if(ac > 1)
    {
      while(ac-- > 1)
      {
        trans.getParams()[ac].setLong(atom_getlong(&av[ac]));
      }
    }
    deferMethod<TransientMax,&TransientMax::do_process>(s, ac, av);
  }
  
  std::vector<parameter::Instance>& getParams()
  {
    return trans.getParams();
  }

private:
  
  void do_process(t_symbol *s, long ac, t_atom *av)
  {
    bool parametersOk;
    str::TransientNRTClient::ProcessModel processModel;
    std::string whatHappened;//this will give us a message to pass back if param check fails
    std::tie(parametersOk,whatHappened,processModel) = trans.sanityCheck();
    if(!parametersOk)
    {
      object_error(*this, whatHappened.c_str());
      return;
    }
    trans.process(processModel);
    outlet_bang(mOutlets[0]);
  }
  str::TransientNRTClient trans;
  std::vector<t_object*> mOutlets;
};
}
void ext_main(void *r)
{
  fluid::TransientMax::makeClass<fluid::TransientMax>(CLASS_BOX, "fluid.transients~");
}


