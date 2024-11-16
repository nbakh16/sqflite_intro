class NoteModel {
  int id;
  String title;
  String description;
  bool isDone;
  NoteModel({
    this.id = 0,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  factory NoteModel.fromJson(Map<String, Object?> json) {
    return NoteModel(
      id: json['s_no'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      // isDone: json['isDone'] == 1,
    );
  }
}
