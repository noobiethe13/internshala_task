import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/common/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive(height: height, width: width);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text("Home", style: GoogleFonts.inter(
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
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              )
          ),
          onPressed: (){
            Navigator.pushNamed(context, '/');
          },
          child: Text("Go to Internship Search", style: GoogleFonts.inter(
              fontSize: responsive.height14,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),),
        ),
      ),
    );
  }
}
