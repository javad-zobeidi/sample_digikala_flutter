
import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());


class Product {
    final List<ProductItem> items;
    final String section;

    Product({
        this.items,
        this.section,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        items: json["items"] == null ? null : List<ProductItem>.from(json["items"].map((x) => ProductItem.fromJson(x))),
        section: json["section"] == null ? null : json["section"],
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "section": section == null ? null : section,
    };
}

class ProductItem {
    final int id;
    final String name;
    final int price;
    final int discount;
    final int catId;
    final String image;
    final DateTime createdAt;
    final DateTime updatedAt;

    ProductItem({
        this.id,
        this.name,
        this.price,
        this.discount,
        this.catId,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        discount: json["discount"] == null ? null : json["discount"],
        catId: json["cat_id"] == null ? null : json["cat_id"],
        image: json["image"] == null ? null : json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "discount": discount == null ? null : discount,
        "cat_id": catId == null ? null : catId,
        "image": image == null ? null : image,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
