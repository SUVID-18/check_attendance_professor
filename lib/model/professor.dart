class Professor {
  final String id;
  final String name;

  const Professor(this.id, this.name);

  Map<String, String> toJson() => {'id': id, 'name': name};

  factory Professor.fromJson(Map<String, dynamic> json) =>
      Professor(json['id'], json['name']);
}
