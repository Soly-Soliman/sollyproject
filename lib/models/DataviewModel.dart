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

class BasketballModel {
  String? hobbies;
  String? about;
  String? palace;
  String? occasion;
  String? imageURL;


  BasketballModel({
    this.hobbies,
    this.about,
    this.palace,
    this.occasion,
    this.imageURL
  });
  BasketballModel.fromJson(Map<String,dynamic> json)
  {
    hobbies = json['HOBBIES'];
    about =json['About'];
    palace =json['Palace'];
    occasion =json['occasion'];
    imageURL =json['imageURL'];

  }

}

