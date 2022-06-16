import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:graduation_1/models/DataviewModel.dart';

import '../Utils/colors.dart';



class tennis extends StatefulWidget {
  const tennis({Key? key,}) : super(key: key);

  @override
  State<tennis> createState() => _tennisState();
}

class _tennisState extends State<tennis> {
  var values = [];
  var searchValues = [];

  @override
  Widget build(BuildContext buildContext,) {
    ReadJsonData();
    return Scaffold(
        backgroundColor:blue1 ,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48,),
        child: AppBar(
          backgroundColor:selection ,
          foregroundColor: primary,

          title: const Text('BasketBall',),
          centerTitle: true,
        ),
      ),
      body: Scaffold(
        backgroundColor: blue1,
        body:
         FutureBuilder(
          future: ReadJsonData(),
          builder: (context,data){
            if(data.hasError){
              return Center(child: Text("${data.error}"),);
            }else if(data.hasData){
              var items= data.data as List<BasketballModel>;
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
                                  Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].occasion.toString(),style: TextStyle(
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
      )
    );
  }

  /*void getSearchValues(String value) {
    searchValues.clear();
    searchValues = values
        .where(
            (element) {
          DataviewModel dataviewModel = element as DataviewModel;
          return DataviewModel().hobbies.toString().contains(value.toString(),);
        }
    ).toList();*/
   //     .where(
   //         (element) {
   //       DataviewModel _jsonObject = element as DataviewModel;
    //      return _jsonObject.hobbies.toString().startsWith(value.toString(),);
    //    }
   // ).toList();
  }

  Future<List<BasketballModel>> ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/tennis.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => BasketballModel.fromJson(e)).toList();
  }
