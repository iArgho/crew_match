import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'user_detailed_home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> people = [
      {
        'name': 'Emma',
        'age': '25',
        'image':
            'https://i.pinimg.com/736x/7e/33/57/7e3357cfb8ee9bf31cf2a5b427b50a92.jpg',
        'bio':
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        'company': 'Skyline Ventures',
        'ship': 'SS Horizon',
      },
      {
        'name': 'Mia',
        'age': '22',
        'image':
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=800&q=80',
        'bio':
            'Always smiling and full of energy. She thrives in social settings and loves dancing, art, and volunteering for good causes.',
        'company': 'AquaTech Ltd.',
        'ship': 'MV Ocean Pearl',
      },
      {
        'name': 'Liam',
        'age': '28',
        'image':
            'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=80',
        'bio':
            'Music is life for Liam. He plays guitar in a band and writes his own songs. Also loves road trips and vintage cars.',
        'company': 'MarineX',
        'ship': 'SS Voyager',
      },
    ];

    return Scaffold(body: SwipeableCardStack(people: people));
  }
}

class SwipeableCardStack extends StatefulWidget {
  final List<Map<String, String>> people;

  const SwipeableCardStack({super.key, required this.people});

  @override
  _SwipeableCardStackState createState() => _SwipeableCardStackState();
}

class _SwipeableCardStackState extends State<SwipeableCardStack> {
  int currentIndex = 0;
  double dragPosition = 0;
  double rotationAngle = 0;
  bool isDragging = false;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      isDragging = true;
      dragPosition += details.delta.dx;
      rotationAngle = dragPosition < 0 ? (dragPosition / 500 * 0.61) : 0;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    const double swipeThreshold = 150;
    setState(() {
      isDragging = false;
      if (dragPosition.abs() > swipeThreshold) {
        if (dragPosition < 0) {
          print('Disliked: ${widget.people[currentIndex]['name']}');
        } else {
          print('Liked: ${widget.people[currentIndex]['name']}');
        }
        currentIndex = (currentIndex + 1) % widget.people.length;
      }
      dragPosition = 0;
      rotationAngle = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            if (currentIndex < widget.people.length - 1)
              Positioned.fill(
                child: buildCard(
                  context,
                  widget.people[currentIndex + 1],
                  6.w,
                  10.r,
                  false,
                ),
              ),
            if (currentIndex < widget.people.length)
              Positioned.fill(
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Transform.translate(
                    offset: Offset(isDragging ? dragPosition : 0, 0),
                    child: Transform.rotate(
                      angle: rotationAngle,
                      child: buildCard(
                        context,
                        widget.people[currentIndex],
                        6.w,
                        10.r,
                        true,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildCard(
    BuildContext context,
    Map<String, String> person,
    double padding,
    double borderRadius,
    bool isForeground,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Image.network(
              person['image']!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder:
                  (context, child, progress) =>
                      progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 60)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  stops: const [0.0, 0.5],
                ),
              ),
            ),
            if (isForeground)
              Positioned(
                bottom: 30.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => UserDetailedHomePage(
                                  name: person['name']!,
                                  bio: person['bio'] ?? '',
                                  company: person['company'] ?? '',
                                  ship: person['ship'] ?? '',
                                  image: person['image']!,
                                ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${person['name']}, ${person['age']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '“${person['bio']!.split(" ").take(4).join(" ")}...”',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -30.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                dragPosition = -200;
                                _onHorizontalDragEnd(DragEndDetails());
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Colors.red,
                                size: 35.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),

                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ShaderMask(
                              shaderCallback:
                                  (bounds) => const LinearGradient(
                                    colors: [
                                      Color(0xFFD30579),
                                      Color(0xFFFAB558),
                                    ],
                                  ).createShader(bounds),
                              blendMode: BlendMode.srcIn,
                              child: Icon(
                                Icons.favorite,
                                size: 45.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
