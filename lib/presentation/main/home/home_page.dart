import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcard/tcard.dart';

import 'package:crew_match/presentation/main/notification_screen.dart';
import 'package:crew_match/presentation/user/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getAppBarTitle() => "Laim Bayan";

  final List<Map<String, dynamic>> people = const [
    {
      'name': 'Andrew',
      'age': '28',
      'images': [
        'https://media.themoviedb.org/t/p/w500/5ydZ6TluPtxlz5G8nlWMB7SGmow.jpg',
        'https://comingsoon.ae/wp-content/uploads/2025/04/comingsoon.ae-andrew-garfield-2025-04-07_18-46-36_150897.jpg',
        'https://images.mubicdn.net/images/cast_member/24666/cache-194236-1610749412/image-w856.jpg',
      ],
      'bio':
          'Music is life for Liam. He plays guitar in a band and writes his own songs.',
    },
    {
      'name': 'Emma',
      'age': '25',
      'images': [
        'https://i.pinimg.com/736x/7e/33/57/7e3357cfb8ee9bf31cf2a5b427b50a92.jpg',
        'https://m.media-amazon.com/images/M/MV5BMTQ3ODE2NTMxMV5BMl5BanBnXkFtZTgwOTIzOTQzMjE@._V1_.jpg',
        'https://hips.hearstapps.com/hmg-prod/images/Emma-Watson_GettyImages-619546914.jpg?crop=1xw:1.0xh;center,top&resize=640:*',
      ],
      'bio':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    },
    {
      'name': 'Kanady',
      'age': '22',
      'images': [
        'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&iar=0&w=600&hash=833D605FDB6AC3C2D2915F6BF8B4ADA4',
        'https://cdn-images.fleetnews.co.uk/thumbs/960x960/web-clean/1/root/pearson-appointed-chief-operating-officer-bca-uk-remarketing.jpg',
        'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&iar=0&w=600&hash=833D605FDB6AC3C2D2915F6BF8B4ADA4',
      ],
      'bio':
          'Always smiling and full of energy. She thrives in social settings and loves dancing, art, and volunteering for good causes.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
          child: AppBar(
            elevation: 0.8,
            automaticallyImplyLeading: false,
            titleSpacing: 25.w,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getAppBarTitle(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/Bell.svg',
                        width: 22.w,
                        height: 22.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.black87,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 44.r,
                        height: 44.r,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: PeopleCard(people: people),
    );
  }
}

class PeopleCard extends StatefulWidget {
  final List<Map<String, dynamic>> people;

  const PeopleCard({super.key, required this.people});

  @override
  State<PeopleCard> createState() => _PeopleCardState();
}

class _PeopleCardState extends State<PeopleCard> {
  late TCardController _controller;

  @override
  void initState() {
    _controller = TCardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards =
        widget.people.map((person) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            margin: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: false,
                      pageSnapping: true,
                      scrollPhysics: const ClampingScrollPhysics(),
                    ),
                    items:
                        (person['images'] as List<String>).map((imgUrl) {
                          return Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          );
                        }).toList(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 180.h,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black87, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20.w,
                    bottom: 30.h,
                    right: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Spacer(),
                            Container(
                              width: 55.r,
                              height: 55.r,
                              decoration: BoxDecoration(
                                color: Colors.white, // White background
                                shape:
                                    BoxShape
                                        .circle, // Optional: makes it circular
                              ),
                              child: IconButton(
                                onPressed: () => _controller.back(),
                                icon: SvgPicture.asset(
                                  'assets/icons/cross.svg',
                                  color: Colors.red,
                                  width: 28.sp,
                                  height: 28.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              width: 70.r,
                              height: 70.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: () => _controller.forward(),
                                icon: Icon(
                                  Icons.favorite,
                                  size: 44.sp,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Text(
                          '${person['name']}, ${person['age']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '${(person['bio'] as String).split(' ').take(4).join(' ')}...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();

    return Stack(
      children: [
        Positioned(
          top: -20.h,
          left: -22.h,
          right: -22.h,
          bottom: -60.h,
          child: TCard(
            cards: cards,
            controller: _controller,
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            onForward: (index, info) {
              if (index < widget.people.length) {
                final name = widget.people[index]['name'];
                print('Liked $name');
              }
            },
            onBack: (index, info) {
              if (index >= 0 && index < widget.people.length) {
                final name = widget.people[index]['name'];
                print('Disliked $name');
              }
            },
            onEnd: () {
              print('No more cards.');
            },
          ),
        ),
      ],
    );
  }
}
