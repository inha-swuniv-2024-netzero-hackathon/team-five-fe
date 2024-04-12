import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proto_just_design/functions/get_image.dart';
import 'package:proto_just_design/providers/network_provider.dart';
import 'package:proto_just_design/providers/userdata.dart';
import 'package:proto_just_design/widget_datas/default_boxshadow.dart';
import 'package:proto_just_design/widget_datas/default_buttonstyle.dart';
import 'package:proto_just_design/widget_datas/default_color.dart';
import 'package:proto_just_design/main.dart';
import 'package:provider/provider.dart';

class ReviewWritingPage extends StatefulWidget {
  final String restaurantName;
  final String uuid;
  const ReviewWritingPage({
    Key? key,
    required this.restaurantName,
    required this.uuid,
  }) : super(key: key);

  @override
  State<ReviewWritingPage> createState() => _ReviewWritingPageState();
}

class _ReviewWritingPageState extends State<ReviewWritingPage> {
  late String uuid = widget.uuid;
  late String restaurantName = widget.restaurantName;

  PageController reviewPageController = PageController();
  bool titleLineFocus = true;
  bool popPossible = true;
  TextEditingController titleLineController = TextEditingController();
  FocusNode titleLineFocusNode = FocusNode();
  TextEditingController reviewController = TextEditingController();
  FocusNode reviewFocusNode = FocusNode();
  double tasteController = 3.0;
  double serviceController = 3.0;
  double priceController = 3.0;
  PageController imagesController = PageController(viewportFraction: 0.9);
  final picker = ImagePicker();
  List<File> selectedImages = [];

  bool isAnonymous = false;

  void backButton() {
    if (reviewPageController.page == 0) {
      // popPossible = true;
      Navigator.pop(context);
    } else {
      popPossible = false;
      reviewPageController.previousPage(
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  Future<void> registReview() async {
    bool isNetwork = await context.read<NetworkProvider>().checkNetwork();
    if (!isNetwork) {
      return;
    }
    var request = http.MultipartRequest(
        'POST', Uri.parse('${rootURL}v1/restaurants/$uuid/reviews/'));
    String token = context.read<UserDataProvider>().token!;
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });
    request.fields['title'] = titleLineController.text;
    request.fields['content'] = reviewController.text;
    request.fields['is_anonymous'] = isAnonymous.toString();
    request.fields['rating_taste'] = (tasteController * 100).toInt().toString();
    request.fields['rating_price'] = (priceController * 100).toInt().toString();
    request.fields['rating_service'] =
        (serviceController * 100).toInt().toString();

    for (var file in selectedImages) {
      request.files
          .add(await http.MultipartFile.fromPath('review_photos', file.path));
    }

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      reviewPageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
      popPossible = true;
    } else {
      print('Failed to upload files: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: popPossible,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        print('a');
        backButton();
      },
      child: PageView(
        pageSnapping: true,
        allowImplicitScrolling: true,
        controller: reviewPageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          firstOnboardingPage(context),
          secondOnboardingPage(context),
          thirdOnboardingPage(context),
          fourthOnboardingPage(context),
          fifthOnboardingPage(context)
        ],
      ),
    );
  }

  Widget firstOnboardingPage(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          reviewWritePageAppbar(context, '한줄평'),
          Expanded(
              child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        restaurantName,
                        style: const TextStyle(
                          color: ColorStyles.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '에',
                        style: TextStyle(
                          color: ColorStyles.black,
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '방문하신 소감을 한줄로 표현해주세요!',
                    style: TextStyle(
                      color: ColorStyles.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 70),
                  Container(
                    width: 171,
                    height: 171,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: ColorStyles.gray,
                        image: DecorationImage(
                          image: NetworkImage(
                              context.read<UserDataProvider>().userProfile ??
                                  ''),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: Boxshadows.defaultShadow),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '사용자님의 한줄평',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorStyles.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                      width: 280,
                      child: TextField(
                        maxLines: 1,
                        controller: titleLineController,
                        focusNode: titleLineFocusNode,
                        autocorrect: false,
                        autofocus: titleLineFocus,
                        cursorColor: Colors.transparent,
                        onSubmitted: (value) {
                          if (titleLineController.text != '') {
                            reviewPageController.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear);
                          }
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            focusColor: ColorStyles.gray,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                titleLineController.clear();
                              },
                            ),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorStyles.gray))),
                      )),
                  const SizedBox(height: 105),
                  TextButton(
                    style: ButtonStyles.transparenBtuttonStyle,
                    onPressed: () {},
                    child: Container(),
                  )
                ],
              ),
            ),
          )),
          nextPageButton(context, '기록하기', controller: titleLineController)
        ],
      ),
    );
  }

  Widget secondOnboardingPage(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          reviewWritePageAppbar(context, '별점'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    '3가지 항목에 대해 별점을 부여해주세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorStyles.black,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '음식의 맛에 대해 평가해주세요',
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          sliderHelper(context, tasteController),
                          SizedBox(
                            width: 350,
                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    valueIndicatorColor: ColorStyles.yellow,
                                    overlayColor: ColorStyles.yellow),
                                child: Slider(
                                    activeColor: ColorStyles.yellow,
                                    inactiveColor: ColorStyles.ash,
                                    thumbColor: Colors.white,
                                    value: tasteController,
                                    min: 1,
                                    max: 5,
                                    divisions: 4,
                                    label:
                                        '${tasteController.round().toString()}점',
                                    onChanged: (double value) {
                                      setState(() {
                                        tasteController = value;
                                      });
                                    })),
                          )
                        ],
                      ),
                      const Gap(30),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '받으신 서비스를 평가해주세요',
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          sliderHelper(context, serviceController),
                          SizedBox(
                            width: 350,
                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    valueIndicatorColor: ColorStyles.yellow,
                                    overlayColor: ColorStyles.yellow),
                                child: Slider(
                                    activeColor: ColorStyles.yellow,
                                    inactiveColor: ColorStyles.ash,
                                    thumbColor: Colors.white,
                                    value: serviceController,
                                    min: 1,
                                    max: 5,
                                    divisions: 4,
                                    label:
                                        '${serviceController.round().toString()}점',
                                    onChanged: (double value) {
                                      setState(() {
                                        serviceController = value;
                                      });
                                    })),
                          )
                        ],
                      ),
                      const Gap(30),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '체감 가격대에 대해 알려주세요',
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Gap(10),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          sliderHelper(context, priceController),
                          SizedBox(
                            width: 350,
                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    valueIndicatorColor: ColorStyles.yellow,
                                    overlayColor: ColorStyles.yellow),
                                child: Slider(
                                    activeColor: ColorStyles.yellow,
                                    inactiveColor: ColorStyles.ash,
                                    thumbColor: Colors.white,
                                    value: priceController,
                                    min: 1,
                                    max: 5,
                                    divisions: 4,
                                    label:
                                        '${priceController.round().toString()}점',
                                    onChanged: (double value) {
                                      setState(() {
                                        priceController = value;
                                      });
                                    })),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Gap(30),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 15, bottom: 15, right: 20),
                    width: 350,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: Boxshadows.defaultShadow),
                    child: Row(
                      children: [
                        Container(
                            width: 36,
                            height: 36,
                            decoration: ShapeDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(context
                                            .read<UserDataProvider>()
                                            .userProfile ??
                                        ''),
                                    fit: BoxFit.fill),
                                shape: const OvalBorder(),
                                shadows: Boxshadows.defaultShadow)),
                        const SizedBox(width: 13),
                        const Text(
                          '사용자',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          '님의 최종 별점',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorStyles.black,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, color: ColorStyles.yellow),
                        const SizedBox(width: 2),
                        Text(
                          ((tasteController +
                                      serviceController +
                                      priceController) /
                                  3)
                              .toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(10)
                ],
              ),
            ),
          ),
          nextPageButton(context, '기록하기')
        ],
      ),
    );
  }

  Widget sliderHelper(BuildContext context, double controller) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          child: Row(
            children: [
              Container(
                height: 12.0,
                width: 2.0,
                color: ColorStyles.yellow,
              ),
              const Spacer(),
              Container(
                height: 12.0,
                width: 2.0,
                color: controller > 1 ? ColorStyles.yellow : ColorStyles.ash,
              ),
              const Spacer(),
              Container(
                height: 12.0,
                width: 2.0,
                color: controller > 2 ? ColorStyles.yellow : ColorStyles.ash,
              ),
              const Spacer(),
              Container(
                height: 12.0,
                width: 2.0,
                color: controller > 3 ? ColorStyles.yellow : ColorStyles.ash,
              ),
              const Spacer(),
              Container(
                height: 12.0,
                width: 2.0,
                color: controller > 4 ? ColorStyles.yellow : ColorStyles.ash,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget thirdOnboardingPage(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            reviewWritePageAppbar(context, '리뷰 작성'),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    '더 자세한 리뷰를 기록해주세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorStyles.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 70),
                  Container(
                    width: 336,
                    height: 327,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: TextField(
                      maxLength: 500,
                      maxLines: 20,
                      focusNode: reviewFocusNode,
                      controller: reviewController,
                      autocorrect: false,
                      onTap: () {},
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorStyles.ash),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 200),
                  // nextPageButton(context, '기록하기', controller: reviewController)
                ],
              ),
            )),
          ],
        ),
      ),
      bottomNavigationBar: nextPageButton(context, '넘어가기'),
    );
  }

  Widget fourthOnboardingPage(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          reviewWritePageAppbar(context, '사진 등록'),
          const SizedBox(height: 30),
          const Text(
            '사진을 남겨서 리뷰를 완성해주세요!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorStyles.black,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: 360,
            height: 340,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: imagesController,
              itemCount: selectedImages.length + 1,
              itemBuilder: (context, index) {
                if (selectedImages.length == index) {
                  return _photoAddContainer(context);
                }
                return Column(
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent)),
                      onPressed: () {
                        if (imagesController.page != 0) {
                          imagesController.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear);
                        }
                        selectedImages.removeAt(index);
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: const Icon(
                        Icons.close,
                        color: ColorStyles.black,
                        size: 25,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        width: 288,
                        height: 288,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Image.file(selectedImages[index])),
                  ],
                );
              },
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                width: 360,
                child: Row(
                  children: [
                    const Text(
                      '사진에 메뉴판 사진을 추가하였나요?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorStyles.silver,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Switch(
                        inactiveTrackColor: ColorStyles.gray,
                        activeTrackColor: ColorStyles.red,
                        activeColor: Colors.white,
                        value: selectedImages.isNotEmpty,
                        onChanged: (v) {})
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
      bottomNavigationBar: nextPageButton(context, '넘어가기'),
    );
  }

  Widget fifthOnboardingPage(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 229, 229, 1),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    '등록 완료',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorStyles.red,
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 130),
                  const Icon(Icons.celebration_outlined,
                      color: ColorStyles.red, size: 30),
                  const SizedBox(height: 15),
                  const Text(
                    '와우! 첫번째 리뷰 등록을 축하드립니다!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorStyles.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 55),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: ColorStyles.gray,
                        image: DecorationImage(
                          image: NetworkImage(
                              context.read<UserDataProvider>().userProfile ??
                                  ''),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: Boxshadows.defaultShadow),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${context.watch<UserDataProvider>().userName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            nextPageButton(context, '확 인')
          ],
        ),
      ),
    );
  }

  Widget _photoAddContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: SizedBox(
        width: 288,
        height: 288,
        child: DottedBorder(
          dashPattern: const [15, 15],
          borderType: BorderType.RRect,
          radius: const Radius.circular(15),
          color: ColorStyles.silver,
          strokeWidth: 1,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                    style: ButtonStyles.transparenBtuttonStyle,
                    onPressed: () async {
                      List<File> images = await getImages();
                      for (File image in images) {
                        selectedImages.add(image);
                      }
                      setState(() {});
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 45,
                              color: ColorStyles.black,
                            ),
                            SizedBox(height: 15),
                            Text(
                              '파일을 열어 사진 첨부하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorStyles.black,
                                fontSize: 13,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reviewWritePageAppbar(BuildContext context, String pageName) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            TextButton(
                onPressed: () {
                  backButton();
                },
                child: const Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: ColorStyles.red,
                      size: 35,
                    ),
                    Text(
                      '       뒤로가기',
                      style: TextStyle(
                        color: ColorStyles.red,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  pageName,
                  style: const TextStyle(
                    color: ColorStyles.red,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                )),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.help_outline_outlined,
                  size: 20,
                  color: ColorStyles.red,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget nextPageButton(BuildContext context, String buttonName,
      {TextEditingController? controller, List? images}) {
    if (controller != null) {
      return controller.text.isEmpty
          ? Container(
              height: 66,
              alignment: Alignment.center,
              width: double.infinity,
              color: ColorStyles.gray,
              child: Text(
                buttonName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : Container(
              height: 66,
              alignment: Alignment.center,
              width: double.infinity,
              color: ColorStyles.red,
              child: TextButton(
                  onPressed: () {
                    titleLineFocusNode.unfocus();
                    reviewFocusNode.unfocus();
                    popPossible = false;
                    reviewPageController.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                  },
                  style: ButtonStyles.transparenBtuttonStyle,
                  child: Text(
                    buttonName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            );
    }

    return Container(
      height: 66,
      alignment: Alignment.center,
      width: double.infinity,
      color: ColorStyles.red,
      child: TextButton(
          onPressed: () {
            titleLineFocus = false;
            titleLineFocusNode.unfocus();
            popPossible = false;
            setState(() {});
            if (reviewPageController.page == 4) {
              Navigator.pop(context);
            }
            if ((reviewPageController.page == 3) && selectedImages.isNotEmpty) {
              print(context.read<UserDataProvider>().token);
              registReview();
            } else {
              reviewPageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);
            }
          },
          style: ButtonStyles.transparenBtuttonStyle,
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          )),
    );
  }
}
