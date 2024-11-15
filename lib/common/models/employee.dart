class Employee {
  final int id;
  final String firstName;
  final String lastName;
  final String designation;
  final int level;
  final double productivityScore;
  final String currentSalary;
  final int employmentStatus;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.designation,
    required this.level,
    required this.productivityScore,
    required this.currentSalary,
    required this.employmentStatus,
  });

  factory Employee.fromApi(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      designation: json['designation'] ?? '',
      level: json['level'] ?? 0,
      productivityScore: json['productivity_score'] ?? 0.0,
      currentSalary: json['current_salary'] ?? '',
      employmentStatus: json['employment_status'] ?? 0,
    );
  }

factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      designation: json['designation'] ?? '',
      level: json['level'] ?? 0,
      productivityScore: json['productivityScore'] ?? 0.0,
      currentSalary: json['currentSalary'] ?? '',
      employmentStatus: json['employmentStatus'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'designation': designation,
      'level': level,
      'productivityScore': productivityScore,
      'currentSalary': currentSalary,
      'employmentStatus': employmentStatus,
    };
  }
}
