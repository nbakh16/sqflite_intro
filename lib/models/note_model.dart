class NoteModel {
  int id;
  String title;
  String description;
  int isDone;
  NoteModel({
    this.id = 0,
    required this.title,
    required this.description,
    this.isDone = 0,
  });

  factory NoteModel.fromJson(Map<String, Object?> json) {
    return NoteModel(
      id: json['s_no'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      isDone: json['is_done'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {
      's_no': id,
      'title': title,
      'description': description,
      'is_done': isDone,
    };
  }
}
