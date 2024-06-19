import 'dart:convert';

class DailyMenu {
  List<Daily> daily;
  List<Daily> pasta;
  List<Daily> breakfast;

  DailyMenu({
    required this.daily,
    required this.pasta,
    required this.breakfast,
  });

  factory DailyMenu.fromRawJson(String str) =>
      DailyMenu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DailyMenu.fromJson(Map<String, dynamic> json) => DailyMenu(
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
        pasta: List<Daily>.from(json["pasta"].map((x) => Daily.fromJson(x))),
        breakfast:
            List<Daily>.from(json["breakfast"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
        "pasta": List<dynamic>.from(pasta.map((x) => x.toJson())),
        "breakfast": List<dynamic>.from(breakfast.map((x) => x.toJson())),
      };
}

class Daily {
  String date;
  bool isHoliday;
  String holiday;
  List<Product> products;

  Daily({
    required this.date,
    required this.isHoliday,
    required this.holiday,
    required this.products,
  });

  factory Daily.fromRawJson(String str) => Daily.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        date: json["date"],
        isHoliday: json["is_holiday"],
        holiday: json["holiday"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "is_holiday": isHoliday,
        "holiday": holiday,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class AddOrder {
  String date;
  List<Product> products;

  AddOrder({
    required this.date,
    required this.products,
  });

  factory AddOrder.fromRawJson(String str) =>
      AddOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddOrder.fromJson(Map<String, dynamic> json) => AddOrder(
        date: json["date"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String itemId;
  String itemName;
  int itemPrice;
  String itemImage;

  Product({
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        itemImage: json["item_image"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_name": itemName,
        "item_price": itemPrice,
        "item_image": itemImage,
      };
}
