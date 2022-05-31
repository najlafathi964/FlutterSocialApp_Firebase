class CommentModel {
  String? name ;
  String? uId ;
  String? image ;
  String? dateTime ;
  String? text ;
  String? commentImage ;


  CommentModel({
    this.name ,
    this.uId ,
    this.image ,
    this.dateTime ,
    this.text ,
    this.commentImage
  });

  CommentModel.fromJson(Map<String,dynamic> json){
    name = json['name'] ;
    uId = json['uId'] ;
    image = json['image'] ;
    dateTime = json['dateTime'] ;
    text = json['text'] ;
    commentImage = json['commentImage'] ;
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name ,
      'uId' : uId ,
      'image':image ,
      'dateTime':dateTime ,
      'text':text ,
      'commentImage':commentImage ,

    };
  }

}