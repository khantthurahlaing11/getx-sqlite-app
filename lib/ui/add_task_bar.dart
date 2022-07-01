import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gettest/controllers/task_controller.dart';
import 'package:gettest/services/notification_services.dart';
import 'package:gettest/services/theme_services.dart';
import 'package:gettest/ui/theme.dart';
import 'package:gettest/ui/widgets/button.dart';
import 'package:gettest/ui/widgets/input_field.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({ Key? key }) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5,10,15,20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ["None","Daily","Weekly","Monthly"];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode? darkGreyClr : Colors.white,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task",style: headingStyle,),
              MyInputField(title: "Title", hint: 'Enter your title',controller: _titleController,),
              MyInputField(title: "Note", hint: 'Enter your note',controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(onPressed: (){
                _getDateFromUser();
              }, icon: Icon(Icons.calendar_month_outlined,color: Colors.grey,)),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                       hint: _startTime,
                       widget: IconButton(onPressed: (){
                         _getTimeFromUser(isStartTime: true);
                       }, icon: Icon(Icons.access_time_rounded,color: Colors.grey,)),
                       )
                    ),
                    SizedBox(width: 12,),
                     Expanded(
                    child: MyInputField(
                      title: "End Time",
                       hint: _endTime,
                       widget: IconButton(onPressed: (){
                         _getTimeFromUser(isStartTime: false);
                       }, icon: Icon(Icons.access_time_rounded,color: Colors.grey,)),
                       )
                    ),
                ],
              ),
              MyInputField(title: 'Remind', hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
                underline: Container(height: 0),
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()));
                }).toList(), 
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                }),
              ),
              MyInputField(title: 'Repeat', hint: "$_selectedRepeat",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
                underline: Container(height: 0),
                items: repeatList.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(color: Colors.grey),));
                }).toList(), 
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                }),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
        
                  MyButton(label: "Create Task",
                  onTap: (){
                    _validateDate();
                  },
                  )
                ],
              ),
              SizedBox(height: 70,)
            ],
          ),
        ),
      ),
    );
  }

_addTaskToDb()async{
  var value = await  _taskController.addTask(
    task : Task(
    title : _titleController.text,
    note : _noteController.text,
    date : DateFormat.yMd().format(_selectedDate),
    startTime : _startTime,
    endTime : _endTime,
    remind : _selectedRemind,
    repeat : _selectedRepeat,
    color : _selectedColor,
    isCompleted : 0
  )
  );
  print("My Id is "+"$value");
}


_validateDate(){
  if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
    _addTaskToDb();
    Get.back();
  }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
    Get.snackbar('Required', "All fields are required !",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: pinkClr,
    icon: Icon(Icons.warning_amber_rounded,color: Colors.red,)
    );
  }
}

_colorPallete(){
  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Color',style: titleStyle,),
                      SizedBox(height: 8,),
                      Wrap(
                        children: List<Widget>.generate(
                          3, 
                          (int index){
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index==0? primaryClr : index==1?pinkClr:yellowClr,
                                  child: _selectedColor==index?
                                  Icon(Icons.done,size: 16,color: Colors.white):Container(),
                                ),
                              ),
                            );
                          }),
                      )
                    ],
                  );
}

  _appBar(){
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Icon(Icons.arrow_back,size: 20,color: Get.isDarkMode? Colors.white : Colors.black)
    ),
    actions: [
      CircleAvatar(backgroundImage: AssetImage("images/6.jpg"),),
      SizedBox(width: 20,)
    ],
  );
}

_getDateFromUser()async{
  DateTime? _pickerDate = await showDatePicker(
    
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2020), 
    lastDate: DateTime(2023));
    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }else{
      print('Error');
    }
}

_getTimeFromUser({required bool isStartTime})async{
  var pickedtime =  await _showTimePicker();
  String _formatTime = pickedtime.format(context);
  if(pickedtime==null){
    print("Time Cancel");
  }else if(isStartTime==true){
    setState(() {
      _startTime = _formatTime;
    });
  }else if(isStartTime==false){
    setState(() {
      _endTime = _formatTime;
    });
  }
}

_showTimePicker(){
  return showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
    context: context, 
    initialTime: TimeOfDay(
      hour: int.parse(_startTime.split(":")[0]), 
      minute: int.parse(_startTime.split(":")[1].split(" ")[0]))
    );
}

}