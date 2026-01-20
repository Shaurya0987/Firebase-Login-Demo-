class NamesModel {
  String? name;
  int? age;
  String? profession;

  NamesModel({this.name, this.age, this.profession});

  NamesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    profession = json['profession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['profession'] = this.profession;
    return data;
  }
}
