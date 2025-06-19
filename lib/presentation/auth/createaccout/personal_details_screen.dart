import 'package:crew_match/presentation/auth/createaccout/upload_photos_screen.dart';
import 'package:crew_match/presentation/widget/country_picker_dialog_widget.dart';
import 'package:crew_match/presentation/widget/date_picker_form_field.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedCompany;
  String? selectedShip;
  String selectedGender = '';
  String selectedGenderPreference = '';
  RangeValues ageRange = const RangeValues(25, 35);
  final List<String> bannedNationalities = [];

  final List<String> companyList = ['Company A', 'Company B', 'Company C'];
  final List<String> shipList = ['Ship X', 'Ship Y', 'Ship Z'];
  final List<String> allCountries = [
    'Bangladesh',
    'India',
    'United States',
    'Canada',
    'Australia',
    'Germany',
    'Japan',
    'France',
    'Brazil',
  ];

  void _showCountryPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CountryPickerDialogWidget(
          allCountries: allCountries,
          bannedNationalities: bannedNationalities,
          onCountrySelected: (country) {
            setState(() {
              if (!bannedNationalities.contains(country)) {
                bannedNationalities.add(country);
              }
            });
          },
        );
      },
    );
  }

  void _removeNationality(String name) {
    setState(() {
      bannedNationalities.remove(name);
    });
  }

  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      if (selectedGender.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a gender')));
        return;
      }
      if (selectedGenderPreference.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a gender preference')),
        );
        return;
      }
      Navigator.pushNamed(context, '/nextScreen');
    }
  }

  @override
  void dispose() {
    _dobController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 100.h),
                Text(
                  "Personal Details",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Congratulations! You have successfully created your account. Please provide your personal details to find your best match.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                SizedBox(height: 20.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                DatePickerFormField(
                  controller: _dobController,
                  hintText: 'Select your date of birth',
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Gender", style: TextStyle(fontSize: 16.sp)),
                ),
                Row(
                  children:
                      ['Male', 'Female'].map((option) {
                        return Row(
                          children: [
                            Checkbox(
                              value: selectedGender == option,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value! ? option : '';
                                });
                              },
                            ),
                            Text(option),
                            SizedBox(width: 12.w),
                          ],
                        );
                      }).toList(),
                ),
                SizedBox(height: 8.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Short Bio", style: TextStyle(fontSize: 16.sp)),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Write a short bio about yourself',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Company Name",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  value: selectedCompany,
                  hint: const Text("Select Company"),
                  items:
                      companyList
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => selectedCompany = val),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null ? 'Please select a company' : null,
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Ship Name", style: TextStyle(fontSize: 16.sp)),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  value: selectedShip,
                  hint: const Text("Select Ship"),
                  items:
                      shipList
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => selectedShip = val),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Gender Preference",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                Row(
                  children:
                      ['Male', 'Female', 'Both'].map((option) {
                        return Row(
                          children: [
                            Checkbox(
                              value: selectedGenderPreference == option,
                              onChanged: (value) {
                                setState(() {
                                  selectedGenderPreference =
                                      value! ? option : '';
                                });
                              },
                            ),
                            Text(option),
                            SizedBox(width: 12.w),
                          ],
                        );
                      }).toList(),
                ),
                SizedBox(height: 8.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Age Preference",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                RangeSlider(
                  values: ageRange,
                  min: 18,
                  max: 60,
                  divisions: 42,
                  labels: RangeLabels(
                    '${ageRange.start.round()}',
                    '${ageRange.end.round()}',
                  ),
                  activeColor: const Color(0xFFD30579),
                  inactiveColor: const Color(0xFFD30579).withOpacity(0.3),
                  onChanged: (RangeValues values) {
                    setState(() {
                      ageRange = values;
                    });
                  },
                ),
                Text(
                  'Preferred age: ${ageRange.start.round()} - ${ageRange.end.round()}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Banned Nationalities",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    ...bannedNationalities.map((country) {
                      return Chip(
                        label: Text(
                          country,
                          style: const TextStyle(
                            color: Color(0xFFD30579),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          side: const BorderSide(color: Color(0xFFD30579)),
                        ),
                        deleteIcon: const Icon(
                          Icons.close,
                          color: Color(0xFFD30579),
                        ),
                        onDeleted: () => _removeNationality(country),
                      );
                    }),
                    GestureDetector(
                      onTap: _showCountryPickerDialog,
                      child: Chip(
                        label: const Icon(Icons.add, color: Color(0xFFD30579)),
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(
                          side: BorderSide(color: Color(0xFFD30579), width: 1),
                        ),
                        padding: EdgeInsets.all(5.r),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                TextWidgetButton(
                  text: 'Next',
                  onPressed: () {
                    Get.off(() => const UploadPhotosScreen());
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
