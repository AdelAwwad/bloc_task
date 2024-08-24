

class MyProduct{
  List<Product>? product;
  int? total;

  MyProduct({required this.product, required this.total});
  factory MyProduct.getFromMap(Map<String , dynamic> json){
    return MyProduct(product: List<Product>.from(json[Product]), total:json["total"]);
  }
}


class Product{
   int? id;
   String? title;
   Product({required this.id , required this.title});

   factory Product.getFromMap(Map<String , dynamic> map){
     return Product(id:map['id'], title: map['title']);

   }

}