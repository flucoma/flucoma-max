
//#include <clients/nrt/CorpusClient.hpp>
#include <clients/nrt/DataSetClient.hpp>
#include <clients/nrt/DataSetQueryClient.hpp>
#include <clients/nrt/LabelSetClient.hpp>
#include <clients/nrt/KDTreeClient.hpp>
#include <clients/nrt/KMeansClient.hpp>
#include <clients/nrt/KNNClassifierClient.hpp>
#include <clients/nrt/KNNRegressorClient.hpp>
#include <clients/nrt/NormalizeClient.hpp>
#include <clients/nrt/StandardizeClient.hpp>
#include <clients/nrt/RobustScaleClient.hpp>
#include <clients/nrt/PCAClient.hpp>
#include <clients/nrt/MDSClient.hpp>
#include <clients/nrt/UMAPClient.hpp>
#include <clients/rt/AudioTransportClient.hpp>
#include <clients/nrt/NMFCrossClient.hpp>
#include <clients/rt/NMFMorphClient.hpp>
#include <clients/nrt/NNDSVDClient.hpp>
#include <clients/nrt/MLPRegressorClient.hpp>
#include <clients/nrt/MLPClassifierClient.hpp>
#include "FluidMaxWrapper.hpp" //nb: this include is order-sensitive because of macro name clashes in Eigen and C74


void ext_main(void*)
{
  using namespace fluid::client;
  makeMaxWrapper<NRTThreadedDataSetClient>("fluid.dataset~");
  makeMaxWrapper<NRTThreadedDataSetQueryClient>("fluid.datasetquery~");
  makeMaxWrapper<NRTThreadedLabelSetClient>("fluid.labelset~");
  makeMaxWrapper<RTKDTreeClient>("fluid.kdtree~");
  makeMaxWrapper<RTKMeansClient>("fluid.kmeans~");
  makeMaxWrapper<RTKNNClassifierClient>("fluid.knnclassifier~");
  makeMaxWrapper<RTKNNRegressorClient>("fluid.knnregressor~");
  makeMaxWrapper<RTNormalizeClient>("fluid.normalize~");
  makeMaxWrapper<RTStandardizeClient>("fluid.standardize~");
  makeMaxWrapper<RTRobustScaleClient>("fluid.robustscale~");
  makeMaxWrapper<RTPCAClient>("fluid.pca~");
  makeMaxWrapper<NRTThreadedMDSClient>("fluid.mds~");
  makeMaxWrapper<RTUMAPClient>("fluid.umap~");
  makeMaxWrapper<RTMLPRegressorClient>("fluid.mlpregressor~");
  makeMaxWrapper<RTMLPClassifierClient>("fluid.mlpclassifier~");
}
