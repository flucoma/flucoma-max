
#include <clients/nrt/CorpusClient.hpp>
#include <clients/nrt/DatasetClient.hpp>
#include <clients/nrt/KDTreeClient.hpp>
#include <clients/nrt/KMeansClient.hpp>
#include <clients/nrt/KNNClasClient.hpp>
#include <clients/nrt/KNNRegClient.hpp>
#include <clients/nrt/TestClient.hpp>
#include "FluidMaxWrapper.hpp" //nb: this include is order-sensitive because of macro name clashes in Eigen and C74


void ext_main(void*)
{
  using namespace fluid::client;
  //makeMaxWrapper<NRTThreadedCorpus>("fluid.corpus~");
  makeMaxWrapper<NRTThreadedDatasetClient>("fluid.dataset~");
  makeMaxWrapper<NRTThreadedKDTreeClient>("fluid.kdtree~");
  makeMaxWrapper<NRTThreadedKMeansClient>("fluid.kmeans~");
  makeMaxWrapper<NRTThreadedKNNClasClient>("fluid.knnclas~");
  makeMaxWrapper<NRTThreadedKNNRegClient>("fluid.knnreg~");
  makeMaxWrapper<NRTThreadedTestClient>("fluid.test~");
}
