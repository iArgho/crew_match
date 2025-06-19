import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryPickerDialogWidget extends StatefulWidget {
  final List<String> allCountries;
  final List<String> bannedNationalities;
  final Function(String) onCountrySelected;

  const CountryPickerDialogWidget({
    super.key,
    required this.allCountries,
    required this.bannedNationalities,
    required this.onCountrySelected,
  });

  @override
  State<CountryPickerDialogWidget> createState() =>
      _CountryPickerDialogWidgetState();
}

class _CountryPickerDialogWidgetState extends State<CountryPickerDialogWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCountries = [];

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a Country'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search country',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 250.h,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final alreadyAdded = widget.bannedNationalities.contains(
                  country,
                );
                return ListTile(
                  title: Text(country),
                  trailing: IconButton(
                    icon: Icon(
                      alreadyAdded ? Icons.check : Icons.add,
                      color: alreadyAdded ? Colors.grey : Colors.pink,
                    ),
                    onPressed:
                        alreadyAdded
                            ? null
                            : () {
                              Navigator.pop(context);
                              widget.onCountrySelected(country);
                            },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
