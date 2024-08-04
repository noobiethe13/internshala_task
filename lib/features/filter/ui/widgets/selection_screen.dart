import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/responsive.dart';

class SelectionScreen extends ConsumerStatefulWidget {
  final String title;
  final StateProvider<List<String>> provider;
  final StateProvider<List<String>> selectedProvider;

  const SelectionScreen({
    Key? key,
    required this.title,
    required this.provider,
    required this.selectedProvider,
  }) : super(key: key);

  @override
  ConsumerState<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends ConsumerState<SelectionScreen> {
  late List<String> filteredItems;
  late List<String> tempSelectedItems;

  @override
  void initState() {
    super.initState();
    filteredItems = ref.read(widget.provider);
    tempSelectedItems = List.from(ref.read(widget.selectedProvider));
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = ref.read(widget.provider)
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive(height: height, width: width);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: responsive.width30,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_outlined, color: Colors.black,)),
        title: Text(widget.title, style: GoogleFonts.inter(
          fontSize: responsive.height20,
          fontWeight: FontWeight.w600,
          color: Colors.black,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      tempSelectedItems.clear();
                    });
                  },
                  child: Text('Clear All', style: GoogleFonts.inter(
                      fontSize: responsive.height14,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightBlue
                  )),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(widget.selectedProvider.notifier).state = List.from(tempSelectedItems);
                    Navigator.pop(context);
                  },
                  child: Text('Apply', style: GoogleFonts.inter(
                    fontSize: responsive.height14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  )),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(8.0),
                    backgroundColor: Colors.lightBlue,
                    minimumSize: Size(responsive.width100, responsive.height30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                SizedBox(width: responsive.width10,),
                Icon(CupertinoIcons.bell, color: Colors.black),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.black,
              onChanged: _filterItems,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Search Profile',
                labelStyle: GoogleFonts.inter(
                  color: Colors.grey
                ),
                constraints: BoxConstraints(
                  maxHeight: responsive.height50,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                      width: 2,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightBlue,
                    width: 2,
                  )
                )
              ),
            ),
          ),
          if (tempSelectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: SizedBox(
                height: responsive.height40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tempSelectedItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        backgroundColor: Colors.lightBlue,
                        label: Text(tempSelectedItems[index]),
                        labelStyle: GoogleFonts.inter(color: Colors.white),
                        deleteIconColor: Colors.white,
                        side: BorderSide(color: Colors.transparent),
                        onDeleted: () {
                          setState(() {
                            tempSelectedItems.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.lightBlue,
                        side: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        value: tempSelectedItems.contains(item),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              tempSelectedItems.add(item);
                            } else {
                              tempSelectedItems.remove(item);
                            }
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: responsive.height14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}