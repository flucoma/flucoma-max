
#include <clients/nrt/CorpusClient.hpp>
#include <clients/nrt/DatasetClient.hpp>
#include <clients/nrt/KDTreeClient.hpp>
#include <clients/nrt/KMeansClient.hpp>
#include <clients/nrt/KNNClient.hpp>
#include "FluidMaxWrapper.hpp" //nb: this include is order-sensitive because of macro name clashes in Eigen and C74


void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedCorpus>("fluid.corpus~");
  makeMaxWrapper<NRTThreadedDatasetClient>("fluid.dataset~");
  makeMaxWrapper<NRTThreadedKDTreeClient>("fluid.kdtree~");
  makeMaxWrapper<NRTThreadedKMeansClient>("fluid.kmeans~");
  makeMaxWrapper<NRTThreadedKNNClient>("fluid.knn~");
}
