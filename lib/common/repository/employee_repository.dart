import 'package:path/path.dart';
import 'package:promote/common/io/data.dart';
import 'package:sqflite/sqflite.dart';

import '../models/employee.dart';

class EmployeeRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final directory = await getDatabasesPath();
    final path = join(directory, 'employee_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE employees (
            id INTEGER PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            designation TEXT,
            level INTEGER,
            productivityScore REAL,
            currentSalary TEXT,
            employmentStatus INTEGER
          )
          ''',
        );
      },
    );
  }

  Future<List<Employee>> fetchEmployeesFromApi() async {
    final data = Api.successResponse['data'] as List<Map<String, dynamic>>;
    return data.map((json) => Employee.fromApi(json)).toList();
  }

  Future<Map<String, dynamic>> fetchErrorResponseFromApi() async {
    return Api.errorResponse;
  }

  Future<void> saveEmployees(List<Employee> employees) async {
    final db = await database;
    for (var employee in employees) {
      await db.insert(
        'employees',
        employee.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Employee>> getEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');

    return List.generate(
      maps.length,
      (i) {
        return Employee.fromJson(maps[i]);
      },
    );
  }

  Future<void> initApp() async {
    List<Employee> employees = await fetchEmployeesFromApi();

    await saveEmployees(employees);
  }
}
