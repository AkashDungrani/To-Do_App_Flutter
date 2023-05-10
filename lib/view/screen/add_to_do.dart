import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../controller/to_do_controller.dart';
import '../../globals/theme.dart';
import '../../models/to_do_models.dart';
import '../component/button.dart';
import '../component/input_field.dart';
import 'homepage.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selecteDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int selectedColor = 0;
  
  get bluecolor => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar:AppBar(
      elevation: 0,
      title: Text("TODO App",style: TextStyle(color: (Get.isDarkMode) ? Colors.white : Colors.black ),),
      leading:GestureDetector(
        onTap: (){
          setState(() {
            Get.back();
          });
        },
        child: Icon(Icons.arrow_back_ios,color:(Get.isDarkMode)?Colors.white:Colors.black)),
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
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Task",
                  style: Heading,
                ),
                InputField(
                    title: "Title",
                    hint: "Enter your Title",
                    controller: _titleController),
                InputField(
                    title: "Note",
                    hint: "Enter your Note",
                    controller: _noteController),
                InputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selecteDate),
                  widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _getTimeFromUser(isStarTime: true);
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _getTimeFromUser(isStarTime: false);
                            });
                          },
                        ),
                      ),
                    ),
                
              
               
              ],
            ),
            SizedBox(height: 20,),
             Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallete(),
                   
                  ],
                ),
                SizedBox(height: 10,),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     ButtonPage(
                      onTap: () => _validateData(),
                      label: "Add Task",
                ),
                   ],
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateData() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: bluecolor,
        icon: Icon(Icons.warning_amber_rounded),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selecteDate),
        startTime: _startTime,
        endTime: _endTime,
        color: selectedColor,
        isCompleted: 0,
      ),
    );
    print(value);
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                selectedColor = index;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primarycolour
                      : index == 1
                          ? bluecolor
                          : greencolour,
                  child: selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            ),
          ).toList(),
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (_pickerDate != null) {
      _selecteDate = _pickerDate;
      setState(() {});
    } else {}
  }

  _getTimeFromUser({required bool isStarTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStarTime == true) {
      _startTime = _formatedTime;
      setState(() {});
    } else if (isStarTime == false) {
      _endTime = _formatedTime;

      setState(() {});
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  }
