import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:graduation_1/Utils/colors.dart';
import 'package:graduation_1/Utils/utils.dart';
import 'package:graduation_1/models/user.dart';
import 'package:graduation_1/providers/user_provider.dart';
import 'package:graduation_1/resourses/firestore_methods.dart';
import 'package:graduation_1/screens/event/add_event_screen.dart';
import 'package:graduation_1/screens/search_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Chalanges/add_Challange_screen.dart';
import '../hobby/add_hobby_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void UpImagePost(
    String uid,
    String username,
    String profileUrl,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profileUrl);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        }
        );
        showSnackBar('posted', context);
        //the next function is important because it makes the file = to null so the screen back to the first layout that contains the upload immage
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selctImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create Post'),
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
                child: const Text(' choose from Gallary'),
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

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: selection,
                  flexibleSpace: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Container(
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.only(left: 2),
                        //  color: Colors.amber,
                        child: InkWell(
                          onTap: (){},
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(user.photoUrl),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                        height: 55,
                        child: Container(
                          color: selection,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()),
                          );
                        },
                        icon: const Icon(Icons.search_rounded))
                  ],
                ),
                Expanded(
                  child: Container(
                    color: primary,
                    child: Row(children: [
                    Expanded(
                      child: InkWell(
                         onTap:(){
                               Navigator.push(
                                     context,
                                MaterialPageRoute(
                                    builder: (context) => const Add_Event()));
                          } ,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          // height: 45,
                          width: 400,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color:    selection3,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(

                                child: const Text('ADD Event ....'),

                              ),
                              IconButton(
                                icon: const Icon(Icons.event),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Add_Event()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selctImage(context),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: selection3,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: const Text('ADD PHOTO'),
                              ),
                              IconButton(
                                icon: const Icon(Icons.upload_outlined),
                                onPressed: () => _selctImage(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(children: [
                      Expanded(
                        child: Container(

                          child: InkWell(

                            onTap: (){
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const  Add_Hobyy()));
                              }

                            },
                            child: Container(

                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              // height: 45,
                              width: 400,
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                color: selection3,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: const Text('ADD Hobby ..'),
                                  ),
                                  Icon(Icons.event),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const  Add_Challange()));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              color: selection2,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: const Text('Set Challange'),
                                ),
                                Icon(
                                 Icons.upload_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: selection,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: clearImage,
              ),
              title: const Text(
                'ADD POSTS',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () =>
                        UpImagePost(user.uid, user.username, user.photoUrl),
                    child:  Text(
                      'up',
                      style: TextStyle(
                        color:   selection2,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ))
              ],
            ),
            body: ListView(
              children: [
               Column(
                children: [
                  _isLoading
                      ? const LinearProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.only(top: 0),
                        ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.photoUrl),
                          radius: 35,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: ' caption ....',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),

                      const Divider(),
                    ],

                  ),
                  SizedBox(
                    height: 360,
                    width: 360,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),],
            ),
          );
  }
}
