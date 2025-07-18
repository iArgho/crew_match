import 'package:crew_match/presentation/auth/createaccout/upload_photos_screen.dart';
import 'package:crew_match/presentation/user/profile_screen.dart';
import 'package:crew_match/presentation/widget/country_picker_dialog_widget.dart';
import 'package:crew_match/presentation/widget/date_picker_form_field.dart';
import 'package:crew_match/presentation/widget/nationality_picker_widgets.dart';
import 'package:crew_match/presentation/widget/text_widget_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccoutInformationScreen extends StatefulWidget {
  const AccoutInformationScreen({super.key});

  @override
  State<AccoutInformationScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<AccoutInformationScreen> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedNationality;
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
          onCountriesSelected: (selectedCountries) {
            setState(() {
              for (var country in selectedCountries) {
                if (!bannedNationalities.contains(country)) {
                  bannedNationalities.add(country);
                }
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
      Get.off(() => const UploadPhotosScreen());
    }
  }

  @override
  void dispose() {
    _dobController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Information",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.off(ProfileScreen());
          },
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 26.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),
                TextFormField(
                  cursorColor: Colors.black,
                  decoration: _inputDecoration('Enter your Name'),
                  validator:
                      (text) =>
                          (text == null || text.isEmpty)
                              ? 'Enter your Name'
                              : null,
                ),
                SizedBox(height: 18.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                DatePickerFormField(
                  controller: _dobController,
                  hintText: 'Select your date of birth',
                  decoration: _inputDecoration('Select your date of birth'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 16.h),

                /// Gender
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Gender",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
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
                            Text(option, style: TextStyle(fontSize: 14.sp)),
                            SizedBox(width: 12.w),
                          ],
                        );
                      }).toList(),
                ),
                SizedBox(height: 18.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Short Bio",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: _inputDecoration(
                    'Write a short bio about yourself',
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nationality",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                FormField<String>(
                  validator:
                      (value) =>
                          selectedNationality == null
                              ? 'Please select a nationality'
                              : null,
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NationalityPickerWidget(
                          allCountries: allCountries,
                          selectedNationality: selectedNationality,
                          onSelected: (value) {
                            setState(() {
                              selectedNationality = value;
                              state.didChange(value);
                            });
                          },
                        ),
                        if (state.hasError)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h, left: 12.w),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Company Name",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  value: selectedCompany,
                  hint: Text(
                    "Select Company",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  items:
                      companyList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: TextStyle(fontSize: 14.sp)),
                            ),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => selectedCompany = val),
                  decoration: _inputDecoration('Select Company'),
                  validator:
                      (value) =>
                          value == null ? 'Please select a company' : null,
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ship Name",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  value: selectedShip,
                  hint: Text(
                    "Select Ship",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  items:
                      shipList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: TextStyle(fontSize: 14.sp)),
                            ),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => selectedShip = val),
                  decoration: _inputDecoration('Select Ship'),
                  validator:
                      (value) => value == null ? 'Please select a ship' : null,
                ),
                SizedBox(height: 16.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Gender Preference",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
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
                            Text(option, style: TextStyle(fontSize: 14.sp)),
                            SizedBox(width: 12.w),
                          ],
                        );
                      }).toList(),
                ),
                SizedBox(height: 16.h),

                /// Age Preference
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Age Preference",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${ageRange.start.round()} - ${ageRange.end.round()}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                RangeSlider(
                  values: ageRange,
                  min: 18,
                  max: 60,
                  labels: RangeLabels(
                    '${ageRange.start.round()}',
                    '${ageRange.end.round()}',
                  ),
                  activeColor: Colors.red,
                  inactiveColor: Colors.grey.withOpacity(0.3),
                  onChanged:
                      (RangeValues values) => setState(() => ageRange = values),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Banned Nationalities",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8.w,
                    runSpacing: 6.h,
                    children: [
                      ...bannedNationalities.map((country) {
                        return Chip(
                          label: Text(
                            country,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            side: const BorderSide(color: Colors.red),
                          ),
                          deleteIcon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          onDeleted: () => _removeNationality(country),
                        );
                      }),
                      GestureDetector(
                        onTap: _showCountryPickerDialog,
                        child: Chip(
                          label: const Icon(Icons.add, color: Colors.red),
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(
                            side: BorderSide(color: Colors.red, width: 1),
                          ),
                          padding: EdgeInsets.all(5.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),

                TextWidgetButton(
                  text: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context, // Ensure `context` is available in the widget's scope
                      MaterialPageRoute(
                        builder: (context) => UploadPhotosScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 48.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
