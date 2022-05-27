import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graduation_1/resourses/aut_methods.dart';
import 'package:graduation_1/screens/login_screen.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: AppBar(
           actions: [
                IconButton(onPressed: () async{
                  await AuthMethod().SignOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen(),),) ;


                }, icon: Icon(Icons.logout_outlined),),
                    ],
   ),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 200.0,
                    foregroundDecoration: const BoxDecoration(
                    ),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment(-.2, 0),
                          image:NetworkImage(
                              ''),
                          fit: BoxFit.cover),
                    ),

                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child:  const CircleAvatar(
                          radius: 60.0,

                        ),
                      ),
                      const SizedBox(height: 4.0,),
                      const Text('UserName',style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,

                          fontSize: 20.0),
                      ),

                    ],
                  ),





                ],
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration:   InputDecoration(
                    hintText: 'Age',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ) ,
                    hintStyle:   TextStyle(
                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                        onPressed: (){},
                        icon:  Icon(
                          Icons.favorite,
                        )),
                  ),
                  keyboardType:TextInputType.number ,

                  //controller: emailcontroller,
                  validator: (String ?value){
                    if(value!.isEmpty)
                    {
                      return 'Please enter Age';
                    }
                    return null;
                  },


                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration:   InputDecoration(
                    hintText: 'Blood',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ) ,
                    hintStyle:   TextStyle(
                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                        onPressed: (){},
                        icon:  Icon(
                          Icons.favorite,
                        )),
                  ),
                  keyboardType:TextInputType.name ,

                  //controller: emailcontroller,
                  validator: (String ?value){
                    if(value!.isEmpty)
                    {
                      return 'Please enter Blood';
                    }
                    return null;
                  },


                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration:   InputDecoration(
                    hintText: 'Gender',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ) ,
                    hintStyle:   TextStyle(
                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                        onPressed: (){},
                        icon:  Icon(
                          Icons.favorite,
                        )),
                  ),
                  keyboardType:TextInputType.name ,

                  //controller: emailcontroller,
                  validator: (String ?value){
                    if(value!.isEmpty)
                    {
                      return 'Please enter Gender';
                    }
                    return null;
                  },


                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration:   InputDecoration(
                    hintText: 'Height',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ) ,
                    hintStyle:   TextStyle(
                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                        onPressed: (){},
                        icon:  Icon(
                          Icons.favorite,
                        )),
                  ),
                  keyboardType:TextInputType.number ,

                  //controller: emailcontroller,
                  validator: (String ?value){
                    if(value!.isEmpty)
                    {
                      return 'Please enter Height';
                    }
                    return null;
                  },


                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration:   InputDecoration(
                    hintText: 'Weight',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ) ,
                    hintStyle:   TextStyle(
                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                        onPressed: (){},
                        icon:  Icon(
                          Icons.favorite,
                        )),
                  ),
                  keyboardType:TextInputType.number ,

                  //controller: emailcontroller,
                  validator: (String ?value){
                    if(value!.isEmpty)
                    {
                      return 'Please enter Weight';
                    }
                    return null;
                  },


                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration:   InputDecoration(
                    hintText: 'Location',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ) ,
                    hintStyle:   TextStyle(
                      fontSize: 20.0,

                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                        onPressed: (){},
                        icon:  Icon(
                          Icons.location_city,
                        )),
                  ),
                  keyboardType:TextInputType.name ,

                  //controller: emailcontroller,
                  validator: (String ?value){
                    if(value!.isEmpty)
                    {
                      return 'Please enter Location';
                    }
                    return null;
                  },


                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),

                ),
                child: MaterialButton(
                  onPressed: (){
                  },
                  child:  Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 20.0,

                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
