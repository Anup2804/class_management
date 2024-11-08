class LectureNotice {
  
  final List<LectureData> data;


  LectureNotice({
    required this.data,
   
  });

  factory LectureNotice.fromJson(Map<String, dynamic> json) {
    return LectureNotice(
      data: (json['data'] as List)
          .map((item) => LectureData.fromJson(item))
          .toList(),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
     
    };
  }
}

class LectureData {
  final String? id;
  final Teacher? byTeacher;
  final String? adminEmail;
  final String? teacherName;
  final String lectureName;
  final String standard;
  final String date;
  final String time;
  final String description;
  final String board;

  LectureData( {
    this.id,
    this.byTeacher,
    this.adminEmail,
    required this.lectureName,
    required this.standard,
    required this.date,
    required this.time,
    this.teacherName,
    required this.description,
    required this.board,
  });

  factory LectureData.fromJson(Map<String, dynamic> json) {
    return LectureData(
      id: json['_id'],
      byTeacher: Teacher.fromJson(json['byTeacher']),
      adminEmail: json['adminEmail'],
      lectureName: json['lectureName'],
      standard: json['standard'],
      date: json['date'],
      time: json['time'],
      description: json['description'],
      board: json['board'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      // 'byTeacher': byTeacher.toJson(),
      // 'adminEmail': adminEmail,
      'lectureName': lectureName,
      'standard': standard,
      'teacherName':teacherName,
      'date': date,
      'time': time,
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
