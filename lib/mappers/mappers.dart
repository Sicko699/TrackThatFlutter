
import 'package:track_that_flutter/model/baseModel.dart';

abstract class DTOMapper<D, M extends BaseModel> {
  M fromDTO(D dto);

  D toDTO(M model);
}
