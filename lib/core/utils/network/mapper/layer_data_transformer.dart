abstract class LayerDataTransformer<F,T>{

  F restore(T data);

  T transform();
}