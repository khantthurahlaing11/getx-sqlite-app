import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gettest/controllers/task_controller.dart';
import 'package:gettest/services/notification_services.dart';
import 'package:gettest/services/theme_services.dart';
import 'package:gettest/ui/add_task_bar.dart';
import 'package:gettest/ui/theme.dart';
import 'package:gettest/ui/widgets/button.dart';
import 'package:gettest/ui/widgets/task_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';




class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
   NotifyHelper().initializeNotification();
  
  }

  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Get.isDarkMode? darkGreyClr : Colors.white,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10,),
          _showTasks()
        ],

      ),
    );
  }
}

_showTasks(){
  final _taskController = Get.put(TaskController());
   DateTime _selectedDate = DateTime.now();

  return Expanded(
    child: Obx((){
      return ListView.builder(
        itemCount: _taskController.taskList.length,
        itemBuilder: (context,index){  
          Task task = _taskController.taskList[index];
           DateTime _selectedDate = DateTime.now();
           

          if(task.repeat=="Daily"){
            DateTime date = DateFormat.jm().parse(task.startTime.toString());
            var mytime = DateFormat("HH:mm").format(date);
            NotifyHelper().scheduledNotification(
              int.parse(mytime.toString().split(":")[0]), 
              int.parse(mytime.toString().split(":")[1]), 
              task);
            return AnimationConfiguration.staggeredList(
             position: index, 
             child: SlideAnimation(
               child: FadeInAnimation(
                 child: Row(
                   children: [
                     GestureDetector(
                       onTap: (){
                         _showBottomSheet(context,task);
                       },
                       child: TaskTile(task),
                     )
                   ],
                 )
                 ),
             )
             );
          }

          if(task.date==DateFormat.yMd().format(_selectedDate)){
             return AnimationConfiguration.staggeredList(
             position: index, 
             child: SlideAnimation(
               child: FadeInAnimation(
                 child: Row(
                   children: [
                     GestureDetector(
                       onTap: (){
                         _showBottomSheet(context,task);
                       },
                       child: TaskTile(task),
                     )
                   ],
                 )
                 ),
             )
             );
          }else{
            return Container();
          }
        });
    })
    );
}

_showBottomSheet(BuildContext context,Task task){
  
  final _taskController = Get.put(TaskController());

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.only(top: 4),
      height: task.isCompleted==1? 
      MediaQuery.of(context).size.height*0.35
      :
      MediaQuery.of(context).size.height*0.50,
      color: Get.isDarkMode? darkGreyClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode? Colors.grey[600] : Colors.grey[300]
            ),
          ),
          Spacer(),
          task.isCompleted==1? Container() : _bottomSheetButton(
            label: "Task Completed", 
            onTap: (){
              _taskController.markTaskCompleted(task.id!);
              Get.back();
            }, 
            clr: primaryClr),

            
            _bottomSheetButton(
            label: "Delete Task", 
            onTap: (){
              _taskController.delete(task);
              _taskController.getTasks();
              Get.back();
            }, 
            clr: Colors.red[300]!,
            ),
            SizedBox(height: 20,),
            _bottomSheetButton(
            label: "Close", 
            onTap: (){
              Get.back();
            }, 
            isClose: true,
            clr: Colors.red[300]!,
            ),
             SizedBox(height: 10,),
           
        ],
      ),
    )
  );
}

_bottomSheetButton({required String label,
required Function()? onTap,
required Color clr,
bool isClose=false,
}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4,horizontal: 15),
      height: 55,
      width: 500,
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: isClose==true? Get.isDarkMode? Colors.grey[600]! : Colors.grey[300]! : clr),
        borderRadius: BorderRadius.circular(20),
        color: isClose==true? Colors.transparent : clr,
      ),
      child: Center(child: Text(label,
      style: isClose? titleStyle : titleStyle.copyWith(color: Colors.white),
      )),
    ),
  );
}

_addDateBar(){
  
  return Container(
    
            margin: EdgeInsets.only(top: 20,left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 78,
              
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              
              dateTextStyle: GoogleFonts.lato(
                textStyle : TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                
              ),
              ),
               dayTextStyle: GoogleFonts.lato(
                textStyle : TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
              ),
                monthTextStyle: GoogleFonts.lato(
                textStyle : TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
              ),
              onDateChange: (date){
                DateTime _selectedDate = DateTime.now();
                  _selectedDate = date;
              },
            ),
          );
}

_addTaskBar(){
  final _taskController = Get.put(TaskController());
    return   Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(        
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),
                      style: subHeadingStyle,
                      ),
                      Text("Today",style: headingStyle,)
                    ],
                  ),
                ),
                MyButton(label: "+Add Task",onTap: ()async{
                  await Get.to(()=>AddTaskPage());
                  _taskController.getTasks();
                })
              ],
            ),
          );
}

_appBar(){
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
      onTap: (){
        ThemeServices().switchTheme();
        NotifyHelper().displayNotification(title: "Theme Changed", body: Get.isDarkMode? "Activated Light Theme":"Activated Dark Theme");
        // NotifyHelper().scheduledNotification();
        
      },
      child: Icon(Get.isDarkMode?
        Icons.wb_sunny_outlined:
        Icons.nightlight_round,size: 20,color: Get.isDarkMode? Colors.white:Colors.black)
    ),
    actions: [
      CircleAvatar(backgroundImage: AssetImage("images/6.jpg",
      
      ),
      ),
      SizedBox(width: 20,)
    ],
  );
}