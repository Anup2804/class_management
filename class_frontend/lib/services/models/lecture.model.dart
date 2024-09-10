class Lecture {
  final String id;
  final String standard;
  final String lectureName;
  final String teacherName;
  final String time;
  final String description;
  final String board;
  final String adminName;
  final String date;

  Lecture({
    required this.id,
    required this.standard,
    required this.lectureName,
    required this.teacherName,
    required this.time,
    required this.description,
    required this.board,
    required this.adminName,
     required this.date,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['_id'],
      standard: json['standard'],
      lectureName: json['lectureName'],
      teacherName: json['byTeacher']['name'],
      time: json['time'],
      description: json['description'],
      board: json['board'],
      adminName: json['adminName'],
      date: json['date'],
    );
  }
}
