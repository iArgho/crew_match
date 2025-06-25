import 'package:crew_match/presentation/widget/match_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchTileScreen extends StatefulWidget {
  final bool hasMatches;

  const MatchTileScreen({super.key, this.hasMatches = true});

  @override
  State<MatchTileScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchTileScreen> {
  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Emma',
      'age': '25',
      'image':
          'https://i.pinimg.com/736x/7e/33/57/7e3357cfb8ee9bf31cf2a5b427b50a92.jpg',
      'bio': 'Emma loves sailing and the ocean breeze.',
      'company': 'Blue Horizon',
      'ship': 'SS Liberty',
      'date': DateTime.now(),
    },
    {
      'name': 'Sofia',
      'age': '27',
      'image':
          'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=800&q=80',
      'bio': 'Sofia is a curious explorer of the deep sea.',
      'company': 'Aqua Research',
      'ship': 'SS Neptune',
      'date': DateTime.now(),
    },
    {
      'name': 'Liam',
      'age': '27',
      'image':
          'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=800&q=80',
      'bio': 'Liam enjoys songwriting and star-gazing on deck.',
      'company': 'MarineX',
      'ship': 'SS Voyager',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];

  Map<String, List<Map<String, dynamic>>> groupProfilesByDate() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    String getDateLabel(DateTime date) {
      final now = DateTime.now();
      final diff =
          DateTime(
            now.year,
            now.month,
            now.day,
          ).difference(DateTime(date.year, date.month, date.day)).inDays;

      if (diff == 0) return 'Today';
      if (diff == 1) return 'Yesterday';
      return "${date.day}/${date.month}/${date.year}";
    }

    for (var profile in profiles) {
      final label = getDateLabel(profile['date']);
      grouped.putIfAbsent(label, () => []).add(profile);
    }

    return grouped;
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade300, thickness: 0.8)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12.sp),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade300, thickness: 0.8)),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedProfiles = groupProfilesByDate();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              'Matches',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child:
            widget.hasMatches
                ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Text(
                          'This is a list of people who have liked you and your matches.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      ...groupedProfiles.entries.map((entry) {
                        final label = entry.key;
                        final items = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildSectionHeader(label),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.w,
                                    mainAxisSpacing: 16.h,
                                    childAspectRatio: 0.8,
                                  ),
                              itemBuilder: (context, index) {
                                return MatchCardWidget(profile: items[index]);
                              },
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                )
                : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No matched profiles!',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'You don’t have any matched profiles.\nSend match requests to connect!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
