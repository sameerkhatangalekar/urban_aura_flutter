
import 'package:faker/faker.dart';

final faker = Faker();

class MockProductData {
  final int id ;
  final String image;
  final String description;
  final String productName;
  final double price;

  const MockProductData(
      {
        required this.id,
        required this.image,
      required this.productName,
      required this.price,
      required this.description});
}

const homePageProducts = [
  MockProductData(
    id: 1,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 2,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 3,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 4,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: 'Oblong bag',
      description: '',
      price: 120),
  MockProductData(
      id: 5,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 6,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 7,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 8,
      image:'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: 'Oblong bag',
      description: '',
      price: 120),
  MockProductData(
      id: 9,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 10,
      image:'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 11,
      image:'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: '21WN',
      description: 'Reversible angora cardigan',
      price: 120),
  MockProductData(
      id: 12,
      image: 'https://i.postimg.cc/J1QNKsh3/beige-winter-jacket1.webp',
      productName: 'Oblong bag',
      description: '',
      price: 120)
];

class MockAddress {
  final String name;
  final String addressLineOne;
  final String addressLineTwo;
  final String zipcode;
  final String contact;

  MockAddress(
      {required this.name,
      required this.addressLineOne,
      required this.addressLineTwo,
      required this.zipcode,
      required this.contact});

  @override
  String toString() {
    return 'MockAddress{name: $name, addressLineOne: $addressLineOne, addressLineTwo: $addressLineTwo, zipcode: $zipcode, contact: $contact}';
  }
}

final mockAddresses = List.generate(
    4,
    (i) => MockAddress(
        name: faker.person.name(),
        addressLineOne: faker.address.streetAddress(),
        addressLineTwo: faker.address.neighborhood(),
        zipcode: faker.address.zipCode(),
        contact: faker.phoneNumber.us()));
