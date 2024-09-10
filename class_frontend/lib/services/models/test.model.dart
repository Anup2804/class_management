class Test {
  final String id;
  final String standard;
  final String subjectName;
  final String teacherName;
  final String time;
  final String description;
  final String board;
  final String adminName;
  final String? date;

  Test({
    required this.id,
    required this.standard,
    required this.subjectName,
    required this.teacherName,
    required this.time,
    required this.description,
    required this.board,
    required this.adminName,
     this.date,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['_id'],
      standard: json['standard'],
      subjectName: json['subjectName'],
      teacherName: json['byTeacher']['name'],
      time: json['time'],
      description: json['description'],
      board: json['board'],
      adminName: json['adminName'],
      date: json['date'],
    );
  }
}
