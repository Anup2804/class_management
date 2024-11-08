class TestNotice {
  List<TestData> data;

  TestNotice({
    required this.data,
  });

  factory TestNotice.fromJson(Map<String, dynamic> json) {
    return TestNotice(
      data: List<TestData>.from(
          json['data'].map((item) => TestData.fromJson(item))),
    );
  }
}

class TestData {
  String? id;
  Teacher? byTeacher;
  String? adminEmail;
  String subjectName;
  String chapterNo;
  String standard;
  String time;
  String date;
  String? description;
  String board;

  TestData({
    this.id,
    this.byTeacher,
    this.adminEmail,
    required this.chapterNo,
    required this.subjectName,
    required this.standard,
    required this.time,
    required this.date,
    this.description,
    required this.board,
  });

  factory TestData.fromJson(Map<String, dynamic> json) {
    return TestData(
      id: json['_id'],
      byTeacher: Teacher.fromJson(json['byTeacher']),
      adminEmail: json['adminEmail'],
      subjectName: json['subjectName'],
      standard: json['standard'],
      chapterNo: json['chapterNo'],
      time: json['time'],
      date: json['date'],
      description: json['description'] ?? '',
      board: json['board'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'subjectName': subjectName,
      'standard': standard,
      'time': time,
      'chapterNo': chapterNo,
      'date': date,
      'description': description,
      'board': board,
    };
  }
}

class Teacher {
  String id;
  String name;

  Teacher({
    required this.id,
    required this.name,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
