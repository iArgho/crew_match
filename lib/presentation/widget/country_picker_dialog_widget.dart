import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryPickerDialogWidget extends StatefulWidget {
  final List<String> allCountries;
  final List<String> bannedNationalities;
  final Function(List<String>) onCountriesSelected; // multiple countries

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
    if (widget.bannedNationalities.contains(country)) return; // disabled
    setState(() {
      if (_selectedCountries.contains(country)) {
        _selectedCountries.remove(country);
      } else {
        _selectedCountries.add(country);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r), // slightly rounded corners
      ),
      title: const Text('Select Countries'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search country',
                prefixIcon: Icon(Icons.search, color: Colors.pink),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 250.h,
              width: double.maxFinite,
              child:
                  _filteredCountries.isEmpty
                      ? const Center(child: Text('No countries found'))
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
                                    ? Colors.pink.withOpacity(0.1)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                            child: ListTile(
                              title: Text(country),
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
                                        ? Colors.pink
                                        : null,
                              ),
                              onTap:
                                  isBanned
                                      ? null
                                      : () => _toggleSelection(country),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
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
          onPressed: () => Navigator.pop(context), // cancel closes dialog
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            disabledBackgroundColor: Colors.pink.shade100,
          ),
          onPressed:
              _selectedCountries.isEmpty
                  ? null
                  : () {
                    Navigator.pop(context);
                    widget.onCountriesSelected(_selectedCountries.toList());
                  },
          child: const Text('Done'),
        ),
      ],
    );
  }
}
