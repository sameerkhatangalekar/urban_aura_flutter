class ProductData {
 final String image;
 final String productName;
 final double price;

  const ProductData({required this.image,required this.productName,required this.price});



}

const homePageProducts = [
  ProductData(image:  'assets/dress_1.jpg', productName: '21WN reversible angora cardigan', price: 120),
  ProductData(image:  'assets/dress_2.jpg', productName: '21WN reversible angora cardigan', price: 120),
  ProductData(image:  'assets/dress_3.jpg', productName: '21WN reversible angora cardigan', price: 120),
  ProductData(image:  'assets/dress_4.jpg', productName: 'Oblong bag', price: 120)
];