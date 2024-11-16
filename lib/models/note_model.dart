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

  Map<String, Object?> toMap() {
    return {
      's_no': id, // Ensure this matches your table's primary key column name
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0, // Assuming 0/1 storage for boolean in database
    };
  }
}
