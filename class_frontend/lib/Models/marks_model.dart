import 'dart:convert';

class MarksDetails {
    int statusCode;
    MarksData data;
    String message;
    bool success;

    MarksDetails({
        required this.statusCode,
        required this.data,
        required this.message,
        required this.success,
    });

    factory MarksDetails.fromRawJson(String str) => MarksDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MarksDetails.fromJson(Map<String, dynamic> json) => MarksDetails(
        statusCode: json["statusCode"],
        data: MarksData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "message": message,
        "success": success,
    };
}

class MarksData {
    String? id;
    String subjectName;
    String board;
    String chapterNo;
    String standard;
    String file;
    String? description;
    String? teacherName;

    MarksData({
        this.id,
        required this.subjectName,
        required this.board,
        required this.chapterNo,
        required this.standard,
        required this.file,
        this.description,
        this.teacherName,
    });

    factory MarksData.fromRawJson(String str) => MarksData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MarksData.fromJson(Map<String, dynamic> json) => MarksData(
        id: json["_id"],
        subjectName: json["subjectName"],
        board: json["board"],
        chapterNo: json["chapterNo"],
        standard: json["standard"],
        file: json["file"],
        description: json["description"],
        teacherName: json["teacherName"],
    );

    Map<String, dynamic> toJson() => {
        // "_id": id,
        "subjectName": subjectName,
        "board": board,
        "chapterNo": chapterNo,
        "standard": standard,
        "file": file,
        "description": description ?? '',
        // "teacherName": teacherName,
    };
}
