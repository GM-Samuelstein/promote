import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promote/common/models/employee.dart';
import 'package:promote/common/navigation/animated_navigation.dart';
import 'package:promote/common/state_management/app_provider.dart';
import 'package:promote/common/state_management/base_model.dart';
import 'package:promote/presentation/views/details/details_screen.dart';

final appViewmodel = ChangeNotifierProvider((ref) => AppViewmodel());

class AppViewmodel extends BaseModel {
  final _navigation = AnimatedNavigation();
  final ap = AppProvider();

  updateApp() {
    notifyListeners();
  }

  final searchController = TextEditingController();
  List<String> levels = [
    'All',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  String? selectedLevel = 'All';
  List<String> designations = [
    'All',
    'Customer Relations',
    'Human Resources',
    'Legal',
    'Tech',
  ];
  String? selectedDesignation = 'All';
  List<Employee> employeeList = [];
  List<Employee> controlList = [];

  getEmployees() async {
    List<Employee> result = await ap.repository.getEmployees();
    employeeList = result;
    controlList = result;
    filteredEmployeeList = controlList;
    updateApp();
  }

  List<Employee> filteredEmployeeList = [];
  void filterEmployeeList() {
    final query = searchController.text.toLowerCase();

    filteredEmployeeList = controlList.where(
      (employee) {
        String firstName = employee.firstName;
        String lastName = employee.lastName;
        return firstName.toLowerCase().contains(query) ||
            lastName.toLowerCase().contains(query);
      },
    ).toList();
    updateApp();
  }

  filterControlList() {
    List<Employee> control = employeeList;
    if (selectedLevel != 'All') {
      int filterLevelInt = int.parse(selectedLevel ?? '');
      control = control.where((employee) {
        return employee.level == filterLevelInt;
      }).toList();
    }

    if (selectedDesignation != 'All') {
      control = control.where((employee) {
        return employee.designation == selectedDesignation;
      }).toList();
    }

    filteredEmployeeList = control;
    controlList = control;
    updateApp();
  }

  goToEmployeeDetailsScreen(BuildContext context, Employee employee) {
    _navigation.navigateTo(
      context: context,
      animationDuration: 1000,
      destinationScreen: DetailsScreen(employee: employee),
    );
  }

  String employmentStatus = '';
  String employeeSalary = '';

  getEmployeeSalary(int level) {
    switch (level) {
      case 0:
        return '70,000';
      case 1:
        return '100,000';
      case 2:
        return '120,000';
      case 3:
        return '180,000';
      case 4:
        return '200,000';
      case 5:
        return '250,000';
      default:
        return 'N/A';
    }
  }

  getNewLevel({
    required double productivityScore,
    required int oldLevel,
  }) {
    if (productivityScore < 40) {
      return oldLevel - 6;
    } else if (productivityScore < 50) {
      return oldLevel - 1;
    } else if (productivityScore < 80) {
      return oldLevel;
    } else {
      return oldLevel + 1;
    }
  }

  getEmploymentStatus({
    required int oldLevel,
    required int newLevel,
  }) {
    if (newLevel < 0) {
      return 'Employment Terminated';
    } else if (newLevel > oldLevel) {
      return 'Promoted';
    } else if (newLevel < oldLevel) {
      return 'Demoted';
    } else {
      return 'Not Promoted';
    }
  }

  determineEmploymentDetails({
    required double productivityScore,
    required int oldLevel,
  }) async {
    int calculatedNewLevel = await getNewLevel(
        productivityScore: productivityScore, oldLevel: oldLevel);

    employmentStatus = await getEmploymentStatus(
        oldLevel: oldLevel, newLevel: calculatedNewLevel);
    employeeSalary = await getEmployeeSalary(calculatedNewLevel);
  }
}
