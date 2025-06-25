import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryPickerDialogWidget extends StatefulWidget {
  final List<String> allCountries;
  final List<String> bannedNationalities;
  final Function(List<String>) onCountriesSelected;

  const CountryPickerDialogWidget({
    super.key,
    required this.allCountries,
    required this.bannedNationalities,
    required this.onCountriesSelected,
  });

  @override
  State<CountryPickerDialogWidget> createState() =>
      _CountryPickerDialogWidgetState();
}

const Map<String, String> countryCodeMap = {
  'Bangladesh': 'bd',
  'India': 'in',
  'United States': 'us',
  'Canada': 'ca',
  'Australia': 'au',
  'Germany': 'de',
  'Japan': 'jp',
  'France': 'fr',
  'Brazil': 'br',
};

class _CountryPickerDialogWidgetState extends State<CountryPickerDialogWidget> {
  final TextEditingController _searchController = TextEditingController();
  late List<String> _filteredCountries;
  final Set<String> _selectedCountries = {};

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.allCountries;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredCountries =
          widget.allCountries
              .where(
                (country) => country.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
              )
              .toList();
    });
  }

  void _toggleSelection(String country) {
    if (widget.bannedNationalities.contains(country)) return;
    setState(() {
      _selectedCountries.contains(country)
          ? _selectedCountries.remove(country)
          : _selectedCountries.add(country);
    });
  }

  String _getFlagEmoji(String country) {
    final code = countryCodeMap[country]?.toUpperCase() ?? '';
    return String.fromCharCodes(code.codeUnits.map((c) => 0x1F1E6 - 65 + c));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      contentPadding: EdgeInsets.all(16.w),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search country',
                prefixIcon: Icon(
                  Icons.search,
                  size: 20.sp,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 200.h,
              child:
                  _filteredCountries.isEmpty
                      ? Center(
                        child: Text(
                          'No countries found',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          final isBanned = widget.bannedNationalities.contains(
                            country,
                          );
                          final isSelected = _selectedCountries.contains(
                            country,
                          );
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            leading: Text(
                              _getFlagEmoji(country),
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            title: Text(
                              country,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            trailing:
                                isBanned
                                    ? Icon(
                                      Icons.block,
                                      size: 18.sp,
                                      color: Colors.white,
                                    )
                                    : isSelected
                                    ? Icon(
                                      Icons.done,
                                      size: 18.sp,
                                      color: Colors.black,
                                    )
                                    : SizedBox(width: 18.sp),
                            onTap:
                                isBanned
                                    ? null
                                    : () => _toggleSelection(country),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            tileColor:
                                isSelected
                                    ? Colors.grey.withOpacity(0.0)
                                    : null,
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed:
              _selectedCountries.isEmpty
                  ? null
                  : () {
                    widget.onCountriesSelected(_selectedCountries.toList());
                    Navigator.pop(context);
                  },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          ),
          child: Text(
            'Done',
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
