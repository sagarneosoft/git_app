
import 'package:github_user_listing_demo/core/utils/network/mapper/layer_data_transformer.dart';

class BaseLayerTransformer<F,T> implements LayerDataTransformer<F,T>{
  @override
  F restore(T data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  T transform() {
    // TODO: implement transform
    throw UnimplementedError();
  }

}