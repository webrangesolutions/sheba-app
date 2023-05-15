class ReminderMdel {
  String? id;
  String? content;
  String? dueDate;
  bool? isCompleted;
  String? uid;

  ReminderMdel({
    this.id,
    this.content,
    this.dueDate,
    this.isCompleted,
    this.uid,
  });

  ReminderMdel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    content = map["content"];
    dueDate = map["dueDate"];
    isCompleted = map["isCompleted"];
    uid = map["uid"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "content": content,
      "dueDate": dueDate,
      "isCompleted": isCompleted,
      "uid": uid,
    };
  }
}
