import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:graduation_1/JsonScreens/Boxing.dart';
import 'package:graduation_1/models/DataviewModel.dart';

import '../../JsonScreens/Basketball.dart';
import '../../JsonScreens/Bicycling.dart';
import '../../JsonScreens/Drawing.dart';
import '../../JsonScreens/football.dart';
import '../../JsonScreens/racing.dart';
import '../../JsonScreens/swimming.dart';
import '../../JsonScreens/tennis.dart';
import '../../Utils/colors.dart';
import '../../JsonScreens/All_Hoppey_feed_screan.dart';

class HoppyFeedScreen extends StatefulWidget {
  const HoppyFeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HoppyFeedScreen> createState() => _HoppyFeedScreenState();
}

class _HoppyFeedScreenState extends State<HoppyFeedScreen> {
  var values = [];
  var searchValues = [];

  @override
  Widget build(
    BuildContext buildContext,
  ) {
    ReadJsonData();
    return Scaffold(
        backgroundColor: blue1,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            48,
          ),
          child: AppBar(
            backgroundColor: selection,
            foregroundColor: black,
            title: const Text(
              'Learn Hobby',
              style: TextStyle( fontFamily: 'Sofiar' ,color: black),
            ),
            centerTitle: true,
          ),
        ),
        body: Scaffold(
            backgroundColor: blue1,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const All_HoppyFeedScreen()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.shutterstock.com/image-vector/sports-set-athletes-various-disciplines-260nw-1349779070.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BasketBall()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/231-2310196_basketball-clipart-panda-free-images-transparent-png-basketball.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 1,
                          width: 10,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const football()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://previews.123rf.com/images/wannen19/wannen191809/wannen19180900001/108328429-football-logo-designs.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Bicycling()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                               'https://www.freevector.com/uploads/vector/preview/30094/Bicyling-in-the-Park.jpg'
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 1,
                          width: 10,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const tennis()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://thumbs.dreamstime.com/b/print-227781128.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const swimming()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://us.123rf.com/450wm/simplyamazing/simplyamazing2007/simplyamazing200700656/151781568-man-swimming-in-pool-or-ocean-symbol-logo-water-sport-swimming-activity-competition-in-cartoon-flat-.jpg?ver=6'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 1,
                          width: 10,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const racing()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://t4.ftcdn.net/jpg/02/83/90/09/360_F_283900902_TzAgNIBzbuR0RJ6DKOGilJi05YZ5GNPZ.jpg'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Boxing()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://logopond.com/logos/1f8a86c11b5c49c8bb90a218b4a2e3cb.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 1,
                          width: 10,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Drawing()),
                            );
                          },
                          child: Container(
                            width: 180,
                            height: 160,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.pngkey.com/png/detail/392-3921467_pin-by-erika-pineda-on-decoracin-diplomas-artist.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            )

            /*
         FutureBuilder(
          future: ReadJsonData(),
          builder: (context,data){
            if(data.hasError){
              return Center(child: Text("${data.error}"),);
            }else if(data.hasData){
              var items= data.data as List<DataviewModel>;
              return ListView.builder(
                itemCount: items==null? 0:items.length,
                  itemBuilder: (context,index){
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              child: Image(image: NetworkImage(items[index].imageURL.toString()),fit: BoxFit.fill,),
                            ),
                            Expanded(child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].hobbies.toString(),style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),),),
                                  Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].about.toString(),style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),),),
                                  Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].age.toString(),style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),),),
                                  Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].palace.toString(),style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),),),
                                ],

                              ),
                            ),
                            )

                          ],
                        ),
                      ),
                    );
                  }
              );

            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
        */
            ));
  }

  void getSearchValues(String value) {
    searchValues.clear();
    searchValues = values
        .where((element) {
          DataviewModel dataviewModel = element as DataviewModel;
          return DataviewModel().hobbies.toString().contains(
                value.toString(),
              );
        })
        .toList()
        .where((element) {
          DataviewModel _jsonObject = element as DataviewModel;
          return _jsonObject.hobbies.toString().startsWith(
                value.toString(),
              );
        })
        .toList();
  }
}

Future<List<DataviewModel>> ReadJsonData() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('jsonfile/data1.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => DataviewModel.fromJson(e)).toList();
}
