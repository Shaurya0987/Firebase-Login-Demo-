class StudentModel {
  final String name;
  final String college;
  final int semester;
  final String branch;
  final int rollNo;

  StudentModel({
    required this.name,
    required this.college,
    required this.semester,
    required this.branch,
    required this.rollNo,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      college: json['college'],
      semester: json['semester'],
      branch: json['branch'],
      rollNo: json['rollNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'college': college,
      'semester': semester,
      'branch': branch,
      'rollNo': rollNo,
    };
  }
}
