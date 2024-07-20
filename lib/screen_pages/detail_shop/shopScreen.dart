import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proto_just_design/appColors.dart';
import 'package:proto_just_design/model/global/favlist.dart';
import 'package:proto_just_design/model/global/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:proto_just_design/screen_pages/detail_shop/shopVM.dart';

class Shopscreen extends ConsumerStatefulWidget {
  final Restaurant restaurant;
  const Shopscreen(this.restaurant, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopscreenState();
}

Future<void> a(int idx, WidgetRef ref) async {
  final url = Uri.parse('http://3.38.186.181:3000/store/$idx');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData =
        json.decode(utf8.decode(response.bodyBytes));

    List<dynamic> rL = responseData['replyData'];
    List<dynamic> pL = responseData['productData'];
    ref.read(reviewProvider.notifier).setList(rL);
    ref.read(productProvider.notifier).setList(pL);
  } else if (response.statusCode == 401) {}
}

class _ShopscreenState extends ConsumerState<Shopscreen> {
  int value = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await a(1, ref);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Restaurant restaurant = widget.restaurant;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(restaurant.name),
      ),
      body: FutureBuilder(
        future: a(int.parse(restaurant.uuid), ref),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image:
                        DecorationImage(image: NetworkImage(restaurant.url))),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(fontSize: 25),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(favProvider.notifier)
                                .setFav(restaurant.uuid);
                          },
                          child: Icon(
                            Icons.favorite,
                            color:
                                ref.watch(favProvider).contains(restaurant.uuid)
                                    ? redAppcolor
                                    : Colors.grey,
                          ),
                        ),
                        const Gap(5),
                        Text(ref.watch(favProvider).contains(restaurant.uuid)
                            ? '${((restaurant.rating * 100 - int.parse(restaurant.uuid) * 23 + 1).toStringAsFixed(0))}'
                            : '${((restaurant.rating * 100 - int.parse(restaurant.uuid) * 23).toStringAsFixed(0))}')
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        Text(
                          restaurant.addrses,
                          style: const TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      value = 0;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '상품',
                        style: TextStyle(fontSize: 17),
                      ),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              right: const BorderSide(
                                  color: Colors.grey, width: 1),
                              bottom: BorderSide(
                                  color: greenAppcolor,
                                  width: value == 0 ? 3 : 0))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      value = 1;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '리뷰',
                        style: TextStyle(fontSize: 17),
                      ),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              left: const BorderSide(
                                  color: Colors.grey, width: 1),
                              bottom: BorderSide(
                                  color: greenAppcolor,
                                  width: value == 1 ? 3 : 0))),
                    ),
                  ),
                ],
              ),
              const Gap(30),
              value == 0
                  ? SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ref.watch(productProvider).length,
                        itemBuilder: (BuildContext context, int index) {
                          return _product(ref.watch(productProvider)[index]);
                        },
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ref.watch(reviewProvider).length,
                        itemBuilder: (BuildContext context, int index) {
                          return _review(ref.watch(reviewProvider)[index]);
                        },
                      )),
              Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: const Icon(Icons.shopping_cart),
                  ),
                  const Gap(30),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 50,
                    decoration: BoxDecoration(
                        color: redAppcolor,
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      '리뷰쓰기',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Gap(10)
            ]),
          );
        },
      ),
    );
  }

  Widget _product(Product product) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage(product.image))),
          ),
          const Gap(10),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child:
                Align(alignment: Alignment.topLeft, child: Text(product.name)),
          ),
          Gap(10),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.discountPrice.toString(),
                    style: TextStyle(color: redAppcolor),
                  ),
                  const Gap(5),
                  Text(
                    '${product.price}',
                    style: const TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  const Gap(10)
                ],
              ),
              const Gap(10)
            ],
          ),
        ],
      ),
    );
  }

  Widget _review(Review review) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15),
      width: MediaQuery.sizeOf(context).width * 0.85,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    image: DecorationImage(
                        image: AssetImage('assets/images/image.png'))),
              ),
              const Gap(10),
              Text('${review.name}', style: const TextStyle(fontSize: 16)),
              const Spacer(),
              Icon(
                Icons.thumb_up,
                color: redAppcolor,
              ),
              const Gap(20)
            ],
          ),
          const Gap(10),
          Row(
            children: [Gap(10), Text('${review.text}', maxLines: 3)],
          )
        ],
      ),
    );
  }
}

class Product {
  String name;
  String image;
  int price;
  int discountPrice;

  Product(
      {required this.name,
      required this.image,
      required this.price,
      required this.discountPrice});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        image: json['image'],
        price: json['price'],
        discountPrice: json['discount_price']);
  }
}

class Review {
  String name;
  String text;
  int score;

  Review({required this.name, required this.score, required this.text});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        name: json['name'] ?? 'name', score: json['score'], text: json['text']);
  }
}
