import 'package:promote/common/repository/employee_repository.dart';
import 'package:promote/common/state_management/base_model.dart';

class AppProvider extends BaseModel {
  final repository = EmployeeRepository();
}
