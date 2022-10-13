class PreviewModel{
  String? name;
  String? description;
   PreviewModel({ required this.name, required this.description});
  PreviewModel.fromJson(Map<String, dynamic> json) {

    name = json['strDrink'];
  }
}

