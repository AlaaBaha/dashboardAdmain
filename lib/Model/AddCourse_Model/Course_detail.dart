class Course_detail{
  final String link;
  final String? catalog;
  final String Name;
  final String image;
  Course_detail({ required this.link,required this.catalog,required this.Name, required this.image,});
  Map<String, dynamic> toMap() {
    return {
      'link':this.link,
      'catalog':this.catalog,
      'Name':this.Name,
      'image':this.image,

    };
  }
}