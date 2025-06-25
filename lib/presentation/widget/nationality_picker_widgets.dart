import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NationalityPickerWidget extends StatefulWidget {
  final List<String> allCountries;
  final String? selectedNationality;
  final Function(String) onSelected;

  const NationalityPickerWidget({
    super.key,
    required this.allCountries,
    required this.selectedNationality,
    required this.onSelected,
  });

  @override
  State<NationalityPickerWidget> createState() =>
      _NationalityPickerWidgetState();
}

class _NationalityPickerWidgetState extends State<NationalityPickerWidget> {
  late List<String> filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = widget.allCountries;
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCountries);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries =
          widget.allCountries
              .where((country) => country.toLowerCase().contains(query))
              .toList();
    });
  }

  void _showCountryPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            width: 300.w,
            height: 400.h,
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Nation..',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child:
                      filteredCountries.isNotEmpty
                          ? ListView.separated(
                            itemCount: filteredCountries.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (_, index) {
                              final country = filteredCountries[index];
                              return ListTile(
                                title: Text(country),
                                trailing:
                                    widget.selectedNationality == country
                                        ? const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                        : null,
                                onTap: () {
                                  Navigator.pop(context);
                                  widget.onSelected(country);
                                  _searchController.clear();
                                },
                              );
                            },
                          )
                          : Center(
                            child: Text(
                              'No countries found',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCountryPickerDialog(context),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: "Select Nationality",
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        child: Text(
          widget.selectedNationality ?? 'Select Nationality',
          style: TextStyle(
            fontSize: 14.sp,
            color:
                widget.selectedNationality == null ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}
