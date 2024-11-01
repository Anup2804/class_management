class Test {
  final String? id;
  final Teacher byTeacher;
  final String adminEmail;
  final String subjectName;
  final String chapterNo;
  final String standard;
  final String time;
  final DateTime date;
  final String description;
  final String board;

  Test({
    this.id,
    required this.byTeacher,
    required this.adminEmail,
    required this.subjectName,
    required this.chapterNo,
    required this.standard,
    required this.time,
    required this.date,
    required this.description,
    required this.board,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['_id'] as String,
      byTeacher: Teacher.fromJson(json['byTeacher']),
      adminEmail: json['adminEmail'] as String,
      subjectName: json['subjectName'] as String,
      chapterNo: json['chapterNo'] as String,
      standard: json['standard'] as String,
      time: json['time'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      board: json['board'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'byTeacher': byTeacher.toJson(),
      'adminEmail': adminEmail,
      'subjectName': subjectName,
      'chapterNo': chapterNo,
      'standard': standard,
      'time': time,
      'date': date.toIso8601String(),
      'description': description,
      'board': board,
    };
  }
}

class Teacher {
  final String id;
  final String name;

  Teacher({
    required this.id,
    required this.name,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
