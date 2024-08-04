import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshala_task/features/internships/ui/widgets/internship_list.dart';
import 'package:internshala_task/providers/internship_provider.dart';

import '../../../../core/common/responsive.dart';

class InternshipSearchScreen extends ConsumerStatefulWidget {
  const InternshipSearchScreen({super.key});

  @override
  _InternshipSearchScreenState createState() => _InternshipSearchScreenState();
}

class _InternshipSearchScreenState extends ConsumerState<InternshipSearchScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive(height: height, width: width);
    final internshipsAsyncValue = ref.watch(internshipProvider);
    final internshipsCount = ref.watch(totalInternshipsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text("Internships", style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: responsive.height20,
            color: Colors.black,
          ),
        ),
        leadingWidth: responsive.width30,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: responsive.width150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.search, color: Colors.black),
                  SizedBox(width: responsive.width5),
                  Icon(CupertinoIcons.bookmark, color: Colors.black),
                  Icon(CupertinoIcons.bell, color: Colors.black),
                  Icon(Icons.chat_bubble_outline, color: Colors.black),
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              toolbarHeight: responsive.height75,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/filter');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      width: responsive.width80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: const Color(0xff3995bb),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_alt_outlined,
                            color: Color(0xff3995bb),
                            size: responsive.height20,
                          ),
                          SizedBox(width: responsive.width5),
                          Text(
                            "Filters",
                            style: GoogleFonts.inter(
                              fontSize: responsive.height14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff3995bb),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.height10),
                  Text(
                    "$internshipsCount total internships",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: responsive.height12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.5,
            ),
            const Expanded(
              child: InternshipListScreen(),
            ),
          ],
        ),
    );
  }
}
