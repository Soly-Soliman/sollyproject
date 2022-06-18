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
import '../google_map_screen.dart';

// ignore: must_be_immutable
class Add_feedback extends StatefulWidget {
  const Add_feedback({Key? key}) : super(key: key);

  @override
  _Add_feedbackState createState() => _Add_feedbackState();
}

class _Add_feedbackState extends State<Add_feedback> {
  Uint8List? _file;
  bool _isLoading = false;
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _DescriptionController2 = TextEditingController();
  final TextEditingController _AgeController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();


  void Add_thefeedback(
      String uid ,
      String username ,
      String ProfileImage ,

      ) async{
    try{
   String res = await FireStoreMethods().uploadfeedback
     (
       _DescriptionController.text,
        _DescriptionController2.text ,_nameController.text,
       uid,
       username,
       ProfileImage) ;
   if (res == 'success') {
     setState(() {
       _DescriptionController.text='';
       _nameController.text ='';
       _DescriptionController2.text='';


     });
     showSnackBar(' Done', context);

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

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _DescriptionController.dispose();
    _DescriptionController2.dispose();

    _nameController.dispose();
    _timeController.dispose();
    _placeController.dispose();
    _AgeController.dispose() ;

  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    if (_file == null) {}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selection,
        title:  Center(
          child: Text('Write To Us'),
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
                          'Name',
                          style: TextStyle(
                            color: Colors.black,
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
                  color: Colors.black,
                ),

                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'suggestions ..',
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
                       maxLines: 8,
                      controller: _DescriptionController,


                      decoration: const InputDecoration(
                      hintText: 'suggest...',
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
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8) ,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width ,

                    child: TextField(
                      maxLines: 8,
                      controller: _DescriptionController2,


                      decoration: const InputDecoration(
                        hintText: ' have a problem ? ...',
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
                    onPressed: ()=> Add_thefeedback(user.uid,user.username,user.photoUrl),
                    child: const Text(
                      'Ssnd ',
                      style: const TextStyle(
                        color: Colors.black,
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
