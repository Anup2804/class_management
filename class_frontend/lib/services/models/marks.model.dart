import 'dart:convert';

class Marks {
    List<Mark> mark;

    Marks({
        required this.mark,
    });

    factory Marks.fromRawJson(String str) => Marks.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Marks.fromJson(Map<String, dynamic> json) => Marks(
        mark: List<Mark>.from(json["mark"].map((x) => Mark.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mark": List<dynamic>.from(mark.map((x) => x.toJson())),
    };
}

class Mark {
    String id;
    ByTeacher byTeacher;
    String adminName;
    String subjectName;
    String board;
    String chapterNo;
    String standard;
    String file;
    String description;

    Mark({
        required this.id,
        required this.byTeacher,
        required this.adminName,
        required this.subjectName,
        required this.board,
        required this.chapterNo,
        required this.standard,
        required this.file,
        required this.description,
    });

    factory Mark.fromRawJson(String str) => Mark.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Mark.fromJson(Map<String, dynamic> json) => Mark(
        id: json["_id"],
        byTeacher: ByTeacher.fromJson(json["byTeacher"]),
        adminName: json["adminName"],
        subjectName: json["subjectName"],
        board: json["board"],
        chapterNo: json["chapterNo"],
        standard: json["standard"],
        file: json["file"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "byTeacher": byTeacher.toJson(),
        "adminName": adminName,
        "subjectName": subjectName,
        "board": board,
        "chapterNo": chapterNo,
        "standard": standard,
        "file": file,
        "description": description,
    };
}

class ByTeacher {
    String id;
    String name;

    ByTeacher({
        required this.id,
        required this.name,
    });

    factory ByTeacher.fromRawJson(String str) => ByTeacher.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ByTeacher.fromJson(Map<String, dynamic> json) => ByTeacher(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
