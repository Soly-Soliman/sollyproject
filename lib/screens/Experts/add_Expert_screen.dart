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
import '../../Utils/colors.dart';
import '../../Utils/utils.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../Google/google_map_screen.dart';

// ignore: must_be_immutable
class Add_Expert extends StatefulWidget {
  const Add_Expert({Key? key}) : super(key: key);

  @override
  _Add_ExpertState createState() => _Add_ExpertState();
}

class _Add_ExpertState extends State<Add_Expert> {
  Uint8List? _file;
  bool _isLoading = false;
  final TextEditingController _hobbyDescriptionController = TextEditingController();
  final TextEditingController _AgeController = TextEditingController();
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

  void Add_work(
      String uid ,
      String username ,
      String ProfileImage ,

      ) async{
    try{
   String res = await FireStoreMethods().uploadWork(
       _hobbyDescriptionController.text,
       _nameController.text,
       _placeController.text,
       Date,
       selectedTime.format(context),
       _file!,
       uid,
       username,
       ProfileImage, _AgeController.text);
   if (res == 'success') {
     setState(() {
       _hobbyDescriptionController.text='';
       _nameController.text ='';
       _placeController.text='';
       _isLoading = false;
       _AgeController.text='';


     });
     showSnackBar('Done', context);
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
  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _hobbyDescriptionController.dispose();
    _nameController.dispose();
    _timeController.dispose();
    _placeController.dispose();
    _AgeController.dispose() ;

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
        foregroundColor: black,
        title:  Center(
          child: Text('Expert IN ' ,style: TextStyle(
            fontFamily: 'Lemon' ,
            color: black
          ),),
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
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: selection2,
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      children: [
                        const Text(
                          ' Name',
                          style: TextStyle(
                            color: black,
                            fontSize:17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 15,height: 10,),
                        Container(
                          
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8) ,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: 30,
                            child: TextFormField(
                              controller: _nameController,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                suffixIcon: Icon(
                                  Icons.drive_file_rename_outline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: black,
                ),

                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Expert IN..',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8) ,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width ,

                    child: TextField(
                       maxLines: 2,
                      controller: _hobbyDescriptionController,


                      decoration: const InputDecoration(
                      hintText: 'About',
                        hintStyle : TextStyle(
                          color: Colors.black ,
                        ),
                        suffixIcon: Icon(
                          Icons.account_box,
                        ),
                      ),
                    ),
                  ),
                ),
               /*

                   Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'suggested Day ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    // IconButton(onPressed: (){}, icon: Icon(Icons.date_range),)

                    SizedBox(
                      height: 10.0,
                      width: 30,
                    ),
                    Text(
                      'Time To practice ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RaisedButton(
                      color: Colors.grey.shade400, splashColor: Colors.blueAccent,
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
                        color: Colors.black
                      ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                      width: 50,
                    ),
                    RaisedButton(
                      color: Colors.grey.shade400, splashColor: Colors.blue,
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
                          color: Colors.black
                      ),
                      ),
                    ),
                  ],
                ),
                */
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  ' Experience...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8) ,
                          ),
                          child: TextFormField(
                            maxLines: 4,
                            controller: _placeController,
                            decoration: const InputDecoration(
                              hintText: '........ min Lines: 2,',
                              suffixIcon: Icon(
                                Icons.copyright_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Container( width: 74,
                    child: const Text(
                      'Work',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8) ,
                        ),
                        child: TextFormField(
                          controller: _AgeController,
                          decoration: const InputDecoration(
                            hintText: 'Do You Want TO Work  ..',
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Image',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    _file == null
                        ? InkWell(
                      onTap: () => _selctImage(context),
                          child: Container(
                            child: Icon(
                                  Icons.image,
                                  size: 80,
                                  color: selection2,
                                ),
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
                                size: 70,
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
                  height: 30.0,
                ),
                Container(

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: selection2,
                    borderRadius: BorderRadius.circular(8) ,
                  ),
                  child: MaterialButton(
                    onPressed: ()=> Add_work(user.uid,user.username,user.photoUrl),
                    child: const Text(
                      'Aplay',
                      style: const TextStyle(
                        color: black,
                        fontSize: 30
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
