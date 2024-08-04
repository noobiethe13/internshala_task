import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/common/responsive.dart';
import '../screens/filter_screen.dart';

class CustomDropdownButtonFormField extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive(height: height, width: width);
    final selectedDuration = ref.watch(selectedDurationProvider);

    return Container(
      width: double.infinity,
      child: DropdownButtonFormField<int>(
        value: selectedDuration,
        iconEnabledColor: Colors.lightBlue,
        dropdownColor: Colors.white,
        icon: Icon(CupertinoIcons.chevron_down, color: Colors.grey, size: responsive.height20),
        items: [1, 2, 3, 4, 6, 12, 36].map((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text('$value ${value == 1 ? 'month' : 'months'}'),
          );
        }).toList(),
        onChanged: (int? newValue) {
          ref.read(selectedDurationProvider.notifier).state = newValue;
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: "Choose Duration",
          labelStyle: GoogleFonts.inter(color: Colors.grey, fontSize: responsive.height14),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
          constraints: BoxConstraints(maxHeight: responsive.height50),
        ),
        selectedItemBuilder: (BuildContext context) {
          return [1, 2, 3, 4, 6, 12, 36].map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                '$value ${value == 1 ? 'month' : 'months'}',
                style: TextStyle(
                  color: selectedDuration == value ? Colors.lightBlue : Colors.black,
                ),
              ),
            );
          }).toList();
        },
        menuMaxHeight: responsive.height300,
      ),
    );
  }
}
