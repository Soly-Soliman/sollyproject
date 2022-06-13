class DataviewModel {
  String? hobbies;
  String? about;
  String? palace;
  String? age;
  String? imageURL;


  DataviewModel({
    this.hobbies,
    this.about,
    this.palace,
    this.age,
    this.imageURL
  });
  DataviewModel.fromJson(Map<String,dynamic> json)
  {
    hobbies = json['HOBBIES'];
    about =json['About'];
    palace =json['Palace'];
    age =json['Age'];
    imageURL =json['imageURL'];

  }
}

