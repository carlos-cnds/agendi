class Task {
  int? id;
  int? userId;
  DateTime? begin;
  DateTime? end;
  String? client;
  String? description;
  String? contact;
  double? value;

  Task(
      {this.id,
      this.userId,
      this.begin,
      this.description,
      this.end,
      this.client,
      this.contact,
      this.value});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    begin = DateTime.parse(json['begin'].toString());
    end = DateTime.parse(json['end'].toString());
    client = json['client'];
    description = json['description'];
    contact = json['contact'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['userId'] = userId;
    json['begin'] = begin;
    json['end'] = end;
    json['client'] = client;
    json['description'] = description;
    json['contact'] = contact;
    json['value'] = value;
    return json;
  }
}
