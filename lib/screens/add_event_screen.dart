import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/localization_item.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import '../Utils/colors.dart';
import '../Utils/utils.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'google_map_screen.dart';

// ignore: must_be_immutable
class Add_Event extends StatefulWidget {
  const Add_Event({Key? key}) : super(key: key);

  @override
  _Add_EventState createState() => _Add_EventState();
}

class _Add_EventState extends State<Add_Event> {
  Uint8List? _file;
  bool _isLoading = false;
  final TextEditingController _eventDescriptionController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  late DateTime _dateTime;
  String time1= '00/00';
  TimeOfDay  time0= TimeOfDay.now();
  String Date= '00/00/0000';
  late Localizations _localizations ;

  void create_event(
      String uid ,
      String username ,
      String ProfileImage ,

      ) async{
    try{
   String res = await FireStoreMethods().uploadevent
     (_eventDescriptionController.text,
       _nameController.text,
       _placeController.text,
       Date,
       selectedTime.format(context),
       _file!,
       uid,
       username,
       ProfileImage
   );
   if (res == 'success') {
     setState(() {
       _placeController.text="";
       _eventDescriptionController.text='';
       _nameController.text='';
       _isLoading = false;


     });
     showSnackBar('Event Created', context);
     //the next function is important because it makes the file = to null so the screen back to the first layout that contains the upload immage
     clearImage();

   } else {
     setState(() {
       _isLoading = false;
     });
     showSnackBar(res, context);
   }
    }
    catch(e){

    }

  }
  _selctImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Add Image'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                child: const Text('Take A photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                child: const Text(' Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  Future _choosedate(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Set Date'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                child: const Text('one day'),
                onPressed: () async {
                  _dateTime = (await showDatePicker(
                    initialDatePickerMode: DatePickerMode.day,
                    initialEntryMode: DatePickerEntryMode.calendar,
                    confirmText: 'ok',
                    fieldHintText: 'event for one day ',
                    helpText: 'Event\'s DAY',

                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2030),
                  ))!;
                  setState(() {
                    final now = DateTime.now();
                    Date=DateFormat('dd/MM/yyyy').format(_dateTime);
                    //Date =_dateTime.toString();
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                child: const Text('multi days'),
                onPressed: ()async {
                  _dateTime = (await showDatePicker(
                    initialDatePickerMode: DatePickerMode.day,
                    initialEntryMode: DatePickerEntryMode.calendar,
                    confirmText: 'ok',
                    fieldHintText: 'event for one day ',
                    helpText: 'Event\'s DAY',

                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2030),
                  ))!;
                  setState(() {
                    final now = DateTime.now();
                    Date=DateFormat('dd/MM/yyyy').format(_dateTime);
                    //Date =_dateTime.toString();
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(10),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }



  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _eventDescriptionController.dispose();
    _nameController.dispose();
    _timeController.dispose();
    _placeController.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }
  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            PlacePicker(
            "AIzaSyBvZz649nf18qks0X_LNPtbilX1tUL9uzk" ,
              displayLocation: const LatLng(30.039234, 31.224565),

        ),

        ),
    );

    // Handle the result in your way
    print(result);
  }
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    if (_file == null) {}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selection,
        title: const Center(
          child: Text('Create New Event'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: selection2,
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                const Text(
                  'Event Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'name',
                    suffixIcon: Icon(
                      Icons.account_box,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Discription',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _eventDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Discription',
                    suffixIcon: Icon(
                      Icons.account_box,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Date',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // IconButton(onPressed: (){}, icon: Icon(Icons.date_range),)

                    SizedBox(
                      height: 10.0,
                      width: 120,
                    ),
                    Text(
                      'Time',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RaisedButton(
                      color: selection, splashColor: Colors.blueAccent,
                        mouseCursor:MouseCursor.uncontrolled,
                      onPressed: ()
                    async {
                      _dateTime = (await showDatePicker(
                        initialDatePickerMode: DatePickerMode.day,
                        initialEntryMode: DatePickerEntryMode.calendar,
                        confirmText: 'ok',
                        fieldHintText: 'event for one day ',
                        helpText: 'Event\'s DAY',

                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030),
                      ))!;
                      setState(() {
                        final now = DateTime.now();
                            Date=DateFormat('dd/MM/yyyy').format(_dateTime);
                        //Date =_dateTime.toString();
                      });
                    },
                      child:
                      Text(
                        Date,style: const TextStyle(
                        color: Colors.white
                      ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                      width: 50,
                    ),
                    RaisedButton(
                      color:selection, splashColor: Colors.blue,
                      mouseCursor:MouseCursor.uncontrolled,
                      onPressed: ()
                      async {
                        final TimeOfDay timeOfDay = (await
                         showTimePicker(
                             context: context,
                             initialTime: selectedTime,
                           initialEntryMode: TimePickerEntryMode.dial,

                         )

                        )! ;
                        setState(() {
                           timeOfDay.format(context) ;
                           time0=timeOfDay ;
                           time0.format(context);
                           selectedTime=timeOfDay ;

                        });
                      },
                      child:
                      Text(
                      //  "${selectedTime.hour}:${selectedTime.minute}",
                         "${selectedTime.format(context)}",
                       // "${selectedTime.hourOfPeriod} :${selectedTime.minute}:${selectedTime.period}",
                        style: const TextStyle(
                          color: Colors.white
                      ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Place',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    labelText: 'Enter the place ',
                    suffixIcon: Icon(
                      Icons.location_on,
                    ),
                  ),
                ),
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5)
                 ),
                 child: FlatButton(
                   color: selection2,
                   onPressed:()
                   {Navigator.of(context).push(MaterialPageRoute(builder:(context) =>  GoogleMapPage(), ),);}
                   ,child: Row(
                     children: [
                        Icon(Icons.location_on,size: 25, color: Colors.black,),
                       const Text('go to the Map'),

                     ],
                   ),),
               ) ,
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Image',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    _file == null
                        ?  InkWell(
                      onTap: () => _selctImage(context),

                          child: Icon(
                                Icons.image,
                                size: 80,
                                color: selection,
                              ),
                        )
                        : Container(
                            height: 150.0,
                            width: 150.0,
                            child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: MemoryImage(_file!),

                                    // image: NetworkImage('https://wallpaperaccess.com/full/2213424.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 10.0,
                      width: 20,
                    ),
                    _file == null
                        ? const SizedBox(
                            height: 10.0,
                            width: 20,
                          )
                        : Container(
                            height: 150.0,
                            width: 150.0,
                            child: IconButton(
                              onPressed: clearImage,
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ),
                  ],
                ),
            /*    SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Followers',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/

            /*    SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.nIHOheCbRW7P6_ekPSCx9AHaLH?pid=ImgDet&rs=1'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.nIHOheCbRW7P6_ekPSCx9AHaLH?pid=ImgDet&rs=1'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.nIHOheCbRW7P6_ekPSCx9AHaLH?pid=ImgDet&rs=1'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.nIHOheCbRW7P6_ekPSCx9AHaLH?pid=ImgDet&rs=1'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.nIHOheCbRW7P6_ekPSCx9AHaLH?pid=ImgDet&rs=1'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.nIHOheCbRW7P6_ekPSCx9AHaLH?pid=ImgDet&rs=1'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.nIHOheCbRW7P6_ekPSCx9AHaLH?pid=ImgDet&rs=1'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),color: selection,
                  ),
                  width: double.infinity,
                       alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: ()=> create_event(user.uid,user.username,user.photoUrl),
                    child: const Text(
                      'Create',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
