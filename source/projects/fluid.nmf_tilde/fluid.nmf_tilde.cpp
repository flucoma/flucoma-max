/* Non-real time NMF in Max
 *
 */

#include  "MaxNonRealTimeBase.hpp"
#include "fluid_nmf_tilde_util.h"
#include "version.h"

//#include "algorithms/STFT.hpp"
#include "clients/nrt/NMFClient.hpp"

#include "ext_obex.h"

#include <vector>
#include <array>
#include <algorithm>

namespace fluid {
class NMFMax: public fluid::max::MaxNonRealTimeBase
{
public:
  static void classInit(t_class* c, t_symbol* nameSpace, const char* classname)
  {
    addMethod<NMFMax,&NMFMax::decompose>(c, "process");
    makeAttributes<nmf::NMFClient,NMFMax>(c);
  }

  NMFMax(t_symbol *s, long argc, t_atom *argv)
  {
//    mParams = nmf::NMFClient::newParameterSet();
    attr_args_process(*this, argc, argv);
    mOutlets.push_back((t_object*)bangout(this));
  }
  
  ~NMFMax()
  {
    for(auto&& a: mOutlets)
      object_free(a);
  }
  
  void decompose(t_symbol *s, long ac, t_atom *av)
  {
    if(atom_gettype(av) == A_SYM)
        nmf.getParams()[0].setBuffer( new max::MaxBufferAdaptor(*this, atom_getsym(av)));
    
    if(ac > 1)
    {
      while(ac-- > 1)
      {
        if(atom_gettype(&av[ac]) == A_LONG)
          nmf.getParams()[ac].setLong(atom_getlong(&av[ac]));
      }
    }
    deferMethod<NMFMax,&NMFMax::do_decompose>(s, ac, av);
  }
  
  std::vector<parameter::Instance>& getParams()
  {
    return nmf.getParams(); 
  }
  
private:
  void do_decompose(t_symbol *s, long ac, t_atom *av)
  {
    bool parametersOk;
    nmf::NMFClient::ProcessModel processModel;
    std::string whatHappened;//this will give us a message to pass back if param check fails
    std::tie(parametersOk,whatHappened,processModel) = nmf.sanityCheck();
    if(!parametersOk)
    {
      object_error(*this, "fdNMF: %s \n", whatHappened.c_str());
      return;
    }
    nmf.process(processModel);
  }
  
  nmf::NMFClient nmf; 
  std::vector<t_object*> mOutlets;
};
}//namespace
void ext_main(void *r)
{
  fluid::NMFMax::makeClass<fluid::NMFMax>(CLASS_BOX, "fluid.nmf~");
}


