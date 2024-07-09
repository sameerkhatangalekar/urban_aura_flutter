class ProductData {
 final String image;
 final String description;
 final String productName;
 final double price;

  const ProductData({required this.image,required this.productName,required this.price,required this.description});



}

const homePageProducts = [
  ProductData(image:  'assets/images/dress_1.jpg', productName: '21WN',description: 'Reversible angora cardigan', price: 120),
  ProductData(image:  'assets/images/dress_2.jpg', productName: '21WN',description: 'Reversible angora cardigan', price: 120),
  ProductData(image:  'assets/images/dress_3.jpg', productName: '21WN' ,description: 'Reversible angora cardigan', price: 120),
  ProductData(image:  'assets/images/dress_4.jpg', productName: 'Oblong bag',description: '', price: 120)
];