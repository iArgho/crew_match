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

// Country name → ISO Alpha-2 Code
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
  List<String> _filteredCountries = [];
  final Set<String> _selectedCountries = {};

  @override
  void initState() {
    super.initState();
    _filteredCountries = List.from(widget.allCountries);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
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
      if (_selectedCountries.contains(country)) {
        _selectedCountries.remove(country);
      } else {
        _selectedCountries.add(country);
      }
    });
  }

  String getFlagEmoji(String countryName) {
    final code = countryCodeMap[countryName]?.toUpperCase() ?? '';
    return String.fromCharCodes(code.codeUnits.map((c) => 0x1F1E6 - 65 + c));
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.red),
      prefixIcon: const Icon(Icons.search, color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      title: Text(
        'Select Countries',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: _inputDecoration('Search country'),
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 250.h,
              width: double.maxFinite,
              child:
                  _filteredCountries.isEmpty
                      ? Center(
                        child: Text(
                          'No countries found',
                          style: TextStyle(fontSize: 14.sp, color: Colors.red),
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
                          return Material(
                            color:
                                isSelected
                                    ? Colors.red.withOpacity(0.1)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(5.r),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    getFlagEmoji(country),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    country,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                isBanned
                                    ? Icons.block
                                    : isSelected
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color:
                                    isBanned
                                        ? Colors.grey
                                        : isSelected
                                        ? Colors.red
                                        : Colors.red,
                              ),
                              onTap:
                                  isBanned
                                      ? null
                                      : () => _toggleSelection(country),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                            ),
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
            style: TextStyle(fontSize: 14.sp, color: Colors.red),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            disabledBackgroundColor: Colors.red.withOpacity(0.3),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          onPressed:
              _selectedCountries.isEmpty
                  ? null
                  : () {
                    Navigator.pop(context);
                    widget.onCountriesSelected(_selectedCountries.toList());
                  },
          child: Text(
            'Done',
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
