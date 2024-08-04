import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_task/features/filter/ui/widgets/custom_dropdown.dart';
import '../../../../core/common/responsive.dart';
import '../../../../providers/internship_provider.dart';
import '../widgets/selection_screen.dart';

final selectedProfilesProvider = StateProvider<List<String>>((ref) => []);
final selectedCitiesProvider = StateProvider<List<String>>((ref) => []);
final selectedDurationProvider = StateProvider<int?>((ref) => null);

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive(height: height, width: width);
    final selectedProfiles = ref.watch(selectedProfilesProvider);
    final selectedCities = ref.watch(selectedCitiesProvider);
    final selectedDuration = ref.watch(selectedDurationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: responsive.width30,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
        title: Text(
          "Filters",
          style: GoogleFonts.inter(
            fontSize: responsive.height20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: responsive.width100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.bookmark, color: Colors.black),
                  Icon(CupertinoIcons.bell, color: Colors.black),
                  Icon(Icons.chat_bubble_outline, color: Colors.black),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PROFILE",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: responsive.height14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: responsive.height10),
            if (selectedProfiles.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: responsive.height40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedProfiles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          backgroundColor: Colors.lightBlue,
                          label: Text(selectedProfiles[index]),
                          labelStyle: GoogleFonts.inter(color: Colors.white),
                          deleteIconColor: Colors.white,
                          side: BorderSide(color: Colors.transparent),
                          onDeleted: () {
                            ref.read(selectedProfilesProvider.notifier).state =
                                selectedProfiles.where((i) => i != selectedProfiles[index]).toList();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectionScreen(
                      title: 'Profile',
                      provider: profilesProvider,
                      selectedProvider: selectedProfilesProvider,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(CupertinoIcons.add, color: Colors.lightBlue, size: responsive.height20),
                  SizedBox(width: responsive.width10),
                  Text(
                    "Add Profile",
                    style: GoogleFonts.inter(
                      fontSize: responsive.height14,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.height20),
            Text(
              "CITY",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: responsive.height14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: responsive.height10),
            if (selectedCities.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: responsive.height40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedCities.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          backgroundColor: Colors.lightBlue,
                          label: Text(selectedCities[index]),
                          labelStyle: GoogleFonts.inter(color: Colors.white),
                          deleteIconColor: Colors.white,
                          side: BorderSide(color: Colors.transparent),
                          onDeleted: () {
                            ref.read(selectedCitiesProvider.notifier).state =
                                selectedCities.where((i) => i != selectedCities[index]).toList();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectionScreen(
                      title: 'City',
                      provider: citiesProvider,
                      selectedProvider: selectedCitiesProvider,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(CupertinoIcons.add, color: Colors.lightBlue, size: responsive.height20),
                  SizedBox(width: responsive.width10),
                  Text(
                    "Add City",
                    style: GoogleFonts.inter(
                      fontSize: responsive.height14,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.height20),
            Text(
              "MAXIMUM DURATION (IN MONTHS)",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: responsive.height14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: responsive.height10),
            CustomDropdownButtonFormField(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                ref.read(selectedProfilesProvider.notifier).state = [];
                ref.read(selectedCitiesProvider.notifier).state = [];
                ref.read(selectedDurationProvider.notifier).state = null;
                ref.read(filteredInternshipsProvider.notifier).filterInternships();
              },
              child: Text(
                "Clear All",
                style: GoogleFonts.inter(
                  fontSize: responsive.height16,
                  fontWeight: FontWeight.w500,
                  color: Colors.lightBlue,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(responsive.width160, responsive.height50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                side: BorderSide(color: Colors.lightBlue),
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                await ref.read(filteredInternshipsProvider.notifier).filterInternships();
                Navigator.pop(context);
              },
              child: Text(
                "Apply",
                style: GoogleFonts.inter(
                  fontSize: responsive.height16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(responsive.width160, responsive.height50),
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                side: BorderSide(color: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

