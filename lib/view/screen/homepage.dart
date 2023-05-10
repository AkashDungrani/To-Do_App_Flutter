import 'dart:math';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../dbhelper/db_helper.dart';
import '../../globals/theme.dart';
import '../component/button.dart';
import 'add_to_do.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  Future<List<Map<String, Object?>>?>? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    await DBHelper.dbHelper.initDb();
    data = DBHelper.dbHelper.selectAll(date: '5/5/2023');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
      elevation: 0,
      title: Text("TODO App",style: TextStyle(color: (Get.isDarkMode) ? Colors.white : Colors.black ),),
      leading:Icon(Icons.menu,color:(Get.isDarkMode)?Colors.white:Colors.black),
      actions: [
        GestureDetector(
        onTap: () {
          if (Get.isDarkMode) {
            Get.changeThemeMode(ThemeMode.light);
          } else {
            Get.changeThemeMode(ThemeMode.dark);
          }
        },
        child: Container(
          margin: EdgeInsets.only(right: 20),
          child: Icon(
            (Get.isDarkMode) ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: (Get.isDarkMode) ? Colors.white : Colors.black,
          ),
        ),
      ),
      ],
      backgroundColor: Theme.of(context).backgroundColor,
    ),
      body: Column(
        children: [
          _addTaskBar(),
          
          Expanded(
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  List<Map<String, Object?>>? data1 = snapshot.data;

                  return ListView.builder(
                    itemCount: data1!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: (data1[index]['color'] == 0)
                                ? bluecolour
                                : (data1[index]['color'] == 1)
                                    ? lightbluecolour
                                    : greencolour,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data1[index]['title']}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              " ${data1[index]['startTime']} - ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${data1[index]['endTime']}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          "${data1[index]['note']}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                Expanded(
                                  child: Container(
                                    height: 80,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 0.5,
                                          color: Colors.white,
                                        ),
                                        Transform.rotate(
                                            angle: pi / 2,
                                            child: Text(
                                              "TODO",
                                              style: TextStyle(
                                                fontSize: 12,
                                                height: 3,
                                                color: Colors.white,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Container(padding: EdgeInsets.only(left: 10,right: 10),
            height: 112,width: double.infinity,child: _addDateBar(),),
          SizedBox(height: 5,)
        ],
      ),
    );
  }


  _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
       
        DateTime.now(),
        height: 120,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primarycolour,
        daysCount: 10,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        
        onDateChange: (selectedDate) {
          _selectedDate = selectedDate;
          setState(() {
            data = DBHelper.dbHelper.selectAll(
                date: DateFormat.yMd().format(_selectedDate).toString());
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeading,
                ),
                Text(
                  "Today",
                  style: Heading,
                )
              ],
            ),
          ),
          ButtonPage(
              onTap: () async {
                await Get.to(
                  AddTaskPage(),
                );
                setState(() {});
              },
              label: "+ Add Task"),
        ],
      ),
    );
  }
}
