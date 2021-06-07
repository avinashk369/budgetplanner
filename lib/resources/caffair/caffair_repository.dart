import 'package:budgetplanner/models/BaseModel.dart';
import 'package:budgetplanner/models/CaffairModel.dart';

abstract class CaffairRepository {
  Future<BaseModel<CaffairModel>> getCaffairList(int pageNumber);
}
