class QuoteModel{

 late String quote;

  QuoteModel.fromMap(Map<String,dynamic>map){
    quote=map["quote"];
  }


}