class Product {
  final int id;
  final String category;
  final String name;
  final int price;
  final String image_src;
  final String description;
  final int discount;
  final int finalPrice;
  final bool? isFavourite;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.image_src,
    required this.description,
    required this.discount,
    required this.finalPrice,
    this.isFavourite,
  });

  factory Product.fromJson(dynamic json) {
    return Product(
        id: json['id'],
        category: '${json['category']}',
        name: '${json['name']}',
        price: json['price'],
        image_src: '${json['image-src']}',
        description: '${json['description']}',
        discount: json['discount'],
        finalPrice: json['finalPrice']);
  }

  Map toJson() => {
        'id': id,
        'category': category,
        'name': name,
        'price': price,
        'image-src': image_src,
        'description': description,
        'discount': discount,
        'finalPrice': finalPrice
      };
}

List<Product> popularProducts = [
  Product(
      id: 1,
      category: 'vedicline',
      image_src:
          'https://images-static.nykaa.com/media/catalog/product/8/9/8903599070251.jpg',
      name: "Vedic Line Gold Ojas Pack With Saffron",
      description: '',
      price: 325,
      discount: 20,
      finalPrice: (325 - (0.2 * 325)).toInt()),
  Product(
      id: 2,
      category: 'wella',
      image_src:
          'https://pixiesmediapull-145ca.kxcdn.com/pub/media/catalog/product/cache/c7f01f4867dd450caa32398d52a9c6db/w/e/wella_professionals_elements_renewing_mask_500ml_.jpg',
      name: "Wella Professionals Elements Renewing Mask (500ml)",
      price: 1800,
      description:
          'Elements Renewing Repairing \n Mask Amazon Wood Scent With Nu-tree complex to protect hair against keratin degeneration Paraben-Free\nSulfates Free Formula. Suitable for Damaged Hair',
      discount: 15,
      finalPrice: (1800 - (0.15 * 1800)).toInt()),
  Product(
      id: 3,
      category: 'cacau',
      image_src:
          'https://images-static.nykaa.com/media/catalog/product/4/c/4cf22317898606740900.jpg',
      name: "Cadiveu Brasil Cacau Extreme Repair Conditioner",
      price: 1450,
      description:
          'The perfect solution to repair your damaged hair, Cadiveu Professional Brasil Cacau Extreme Repair Conditioner acts deeply into each hair fiber, recovering the hair from root to tip. Developed to effectively renew hair\'s vitality, it promotes shine and moisturizes hair. It also protects hair against future damage while promoting maximum repair and gloss.',
      discount: 26,
      finalPrice: (1450 - (0.26 * 1450)).toInt()),
  Product(
      id: 4,
      category: 'raaga',
      image_src:
          'https://images-static.nykaa.com/media/catalog/product/tr:w-200,h-200,cm-pad_resize/5/0/509543a8902979025348-1.jpg',
      name: "Raaga Professional Liposoluble Wax White Chocolate",
      price: 990,
      description: '',
      discount: 30,
      finalPrice: (990 - (0.30 * 990)).toInt()),
  Product(
      id: 5,
      category: 'wahl',
      image_src:
          "https://images-static.nykaa.com/media/catalog/product/tr:w-200,h-200,cm-pad_resize/4/0/4015110072058_1_.png",
      name: "WAHL Super Dry Turbo Hair Dryer, 2000W - Maroon",
      price: 3750,
      description: '',
      discount: 26,
      finalPrice: (3750 - (0.26 * 3750)).toInt()),
];
