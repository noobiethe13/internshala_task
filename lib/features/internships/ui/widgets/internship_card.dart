import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/common/responsive.dart';
import '../../../../models/internship_model.dart';

class InternshipCard extends StatelessWidget {
  final Internship internship;

  const InternshipCard({super.key, required this.internship});

  String getRelativeTime(String postedOn) {
    List<String> parts = postedOn.split(' ');
    if (parts.length != 3) {
      return 'Invalid date';
    }

    int? day = int.tryParse(parts[0]);
    String month = parts[1].toLowerCase();
    int? year = int.tryParse(parts[2].replaceAll("'", "")) ?? 0;
    year += 2000;

    Map<String, int> months = {
      'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
      'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12
    };

    int monthNumber = months[month] ?? 1;

    if (day == null || year == 0) {
      return 'Invalid date';
    }

    DateTime postedDate = DateTime(year, monthNumber, day);
    DateTime now = DateTime.now();
    Duration difference = now.difference(postedDate);
    int days = difference.inDays;

    if (days < 0) {
      return 'in the future';
    } else if (days == 0) {
      return 'today';
    } else if (days == 1) {
      return 'yesterday';
    } else if (days < 7) {
      return '$days days ago';
    } else if (days < 30) {
      int weeks = (days / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (days < 365) {
      int months = (days / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      int years = (days / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive(height: height, width: width);
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              internship.title,
              style: GoogleFonts.inter(
                fontSize: responsive.height18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: responsive.height10),
            Text(
              internship.companyName,
              style: GoogleFonts.inter(
                fontSize: responsive.height16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: responsive.height16),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: responsive.height16, color: Colors.grey),
                SizedBox(width: responsive.width5),
                Expanded(
                  child: Text(
                    internship.locations.isEmpty ? "Remote" : internship.locations.join(', '),
                    style: GoogleFonts.inter(fontSize: responsive.height14),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.height16),
            Row(
              children: [
                Icon(Icons.play_circle_outline, size: responsive.height16, color: Colors.grey),
                SizedBox(width: responsive.width5),
                Text(
                  internship.startDate,
                  style: GoogleFonts.inter(fontSize: responsive.height14),
                ),
                SizedBox(width: responsive.width20,),
                Icon(Icons.calendar_today_outlined, size: responsive.height16, color: Colors.grey,),
                SizedBox(width: responsive.width5),
                Text(
                  internship.duration,
                  style: GoogleFonts.inter(fontSize: responsive.height14),
                ),
              ],
            ),
            SizedBox(height: responsive.height16),
            Row(
              children: [
                Icon(Icons.money_outlined, size: responsive.height16, color: Colors.grey),
                SizedBox(width: responsive.width5),
                Text(
                  internship.stipend,
                  style: GoogleFonts.inter(fontSize: responsive.height14),
                ),
              ],
            ),
            SizedBox(height: responsive.height16),
            Wrap(
              spacing: 4,
              children: internship.labels
                  .map((label) => Chip(
                side: const BorderSide(
                    color: Colors.transparent
                ),
                label: Text(label),
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: responsive.height12,
                  color: Colors.grey[700],
                ),
                backgroundColor: Colors.grey[200],
              ))
                  .toList(),
            ),
            Chip(
              side: const BorderSide(
                  color: Colors.transparent
              ),
              label: Text(getRelativeTime(internship.postedOn)),
              labelStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: responsive.height12,
                color: Colors.grey[700],
              ),
              backgroundColor: Colors.grey[200],
            ),
            SizedBox(height: responsive.height16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: (){},
                    child: Text("View Details", style: GoogleFonts.inter(
                      fontSize: responsive.height14,
                      fontWeight: FontWeight.w600,
                      color: Colors.lightBlue,
                    ),)),
                SizedBox(width: responsive.width5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )
                  ),
                  onPressed: () {},
                  child: Text('Apply now', style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: responsive.height12,
                      color: Colors.white
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}