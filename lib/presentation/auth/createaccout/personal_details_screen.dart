import 'package:crew_match/presentation/widget/country_picker_dialog_widget.dart';
import 'package:crew_match/presentation/widget/date_picker_form_field.dart'; // Import the new widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String? selectedCompany;
  String? selectedShip;
  String? gender;
  String? genderPreference;
  RangeValues ageRange = const RangeValues(25, 35);

  final List<String> companyList = ['Company A', 'Company B', 'Company C'];
  final List<String> shipList = ['Ship X', 'Ship Y', 'Ship Z'];
  final List<String> bannedNationalities = [];

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
              bannedNationalities.add(country);
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
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                "Personal Details",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
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
                child: Text("Date of Birth", style: TextStyle(fontSize: 16.sp)),
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
                    ['Male', 'Female'].map((value) {
                      return Expanded(
                        child: RadioListTile<String>(
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(value),
                          ),
                          value: value,
                          groupValue: gender,
                          activeColor: const Color(0xFFD30579),
                          contentPadding: EdgeInsets.zero,
                          onChanged: (val) => setState(() => gender = val),
                        ),
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
              ),
              SizedBox(height: 16.h),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Company Name", style: TextStyle(fontSize: 16.sp)),
              ),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                value: selectedCompany,
                hint: const Text("Select Company"),
                items:
                    companyList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => selectedCompany = val),
                decoration: const InputDecoration(border: OutlineInputBorder()),
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
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => selectedShip = val),
                decoration: const InputDecoration(border: OutlineInputBorder()),
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
                    ['Male', 'Female', 'Both'].map((value) {
                      return Expanded(
                        child: RadioListTile<String>(
                          title: Text(value),
                          value: value,
                          groupValue: genderPreference,
                          onChanged:
                              (val) => setState(() => genderPreference = val),
                        ),
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
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      deleteIcon: const Icon(Icons.close, color: Colors.white),
                      onDeleted: () => _removeNationality(country),
                    );
                  }),
                  GestureDetector(
                    onTap: _showCountryPickerDialog,
                    child: Chip(
                      label: const Icon(Icons.add, color: Colors.white),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 14.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: const Text("Next"),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
