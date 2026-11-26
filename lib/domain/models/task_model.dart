class TaskModel {
  const TaskModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.kategori,
    required this.isCompleted,
  });

  final String id;
  final String judul;
  final String deskripsi;
  final String kategori;
  final bool isCompleted;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'] as String,
    judul: json['judul'] as String,
    deskripsi: json['deskripsi'] as String,
    kategori: json['kategori'] as String,
    isCompleted: json['isCompleted'] as bool,
  );

  TaskModel copyWith({
    String? id,
    String? judul,
    String? deskripsi,
    String? kategori,
    bool? isCompleted,
  }) => TaskModel(
    id: id ?? this.id,
    judul: judul ?? this.judul,
    deskripsi: deskripsi ?? this.deskripsi,
    kategori: kategori ?? this.kategori,
    isCompleted: isCompleted ?? this.isCompleted,
  );
}
