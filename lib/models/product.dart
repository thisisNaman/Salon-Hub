class Product {
  final int id;
  final String category;
  final String name;
  final int price;
  final String image_src;
  final String description;
  final bool? isFavourite;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.image_src,
    required this.description,
    this.isFavourite,
  });

  factory Product.fromJson(dynamic json) {
    return Product(
        id: json['id'],
        category: '${json['category']}',
        name: '${json['name']}',
        price: json['price'],
        image_src: '${json['image-src']}',
        description: '${json['description']}');
  }

  Map toJson() => {
        'id': id,
        'category': category,
        'name': name,
        'price': price,
        'image-src': image_src,
        'description': description
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
  ),
  Product(
    id: 2,
    category: 'wella',
    image_src:
        'https://pixiesmediapull-145ca.kxcdn.com/pub/media/catalog/product/cache/c7f01f4867dd450caa32398d52a9c6db/w/e/wella_professionals_elements_renewing_mask_500ml_.jpg',
    name: "Wella Professionals Elements Renewing Mask (500ml)",
    price: 1800,
    description:
        'Elements Renewing Repairing \n Mask Amazon Wood Scent With Nu-tree complex to protect hair against keratin degeneration Paraben-Free\nSulfates Free Formula. Suitable for Damaged Hair',
  ),
  Product(
    id: 3,
    category: 'wahl',
    image_src:
        "https://images-static.nykaa.com/media/catalog/product/tr:w-200,h-200,cm-pad_resize/4/0/4015110072058_1_.png",
    name: "WAHL Super Dry Turbo Hair Dryer, 2000W - Maroon",
    price: 3750,
    description: '',
  ),
  Product(
    id: 4,
    category: 'ikonic',
    image_src:
        "https://www.ikonicworld.com/pub/media/catalog/product/cache/1dee15635ad016025242be8fbb183c2b/i/k/ik8777barberchairblack1_2.jpg",
    name: "BARBER SALON CHAIR BLACK (IK-8777)",
    price: 70000,
    description:
        "The Ikonic IK-8777 barber chair features a hydraulic swivel pump to ensure comfort for a wide range of client’s height. Made with a strong metal frame with a premium chrome finish, this reclining barber chair is of great quality and excellently durable. The headrest is adjustable and removable depending on your needs and has got extendable footrest for more comfort.Features:Reclining barber chair with amazingly strong metal frame Metal frame with extreme chrome finishMain street barber chair showcasing vintage vibes Adjustable pull out head rest Robust hydraulic swivel pump with locking Soft reclining seat with synchronized back and leg lift moment Strong hydraulic pump for height adjustment Extendable foot rest for more comfort Upholstery can be pre ordered in desired colour",
  ),
];
