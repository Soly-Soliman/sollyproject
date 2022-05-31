
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../block/massages/cubitsocial.dart';
import '../block/massages/statesocial.dart';
import '../models/Massage.dart';
import '../models/user.dart';

class ChatDetails extends StatefulWidget {
  User userModel;

  ChatDetails(this.userModel, {Key? key}) : super(key: key);

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  var textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          SocialCubit.get(context).getMessage(receiverId: widget.userModel.uid);
          return BlocConsumer<SocialCubit,SocialState>(
            listener: (context,state){},
            builder: (context,state){
              if (kDebugMode) {
                print(SocialCubit.get(context).message.length);
              }
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0.0,
                  titleSpacing: 0.0,
                  title: Row(
                    children:  [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(widget.userModel.photoUrl),
                      ),
                      const SizedBox(width: 15.0,),
                      InkWell(
                        onTap: (){
                     //     navigatto(context, AddPostScreen() );
                        },
                        child: Text(
                          widget.userModel.username,
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition:true ,
                  builder: (context)=>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context,index){
                                var message1 = SocialCubit.get(context).message[index];
                                if(SocialCubit.get(context).model!.uid == message1.senderId) {
                                  return buildMyMessage(message1);
                                }else {
                                  return buildMessage(message1);
                                }
                              },
                              separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
                              itemCount: SocialCubit.get(context).message.length),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0
                              ),
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: textcontroller,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type you message',

                                  ),
                                ),
                              ),
                              Container(
                                height: 40.0,
                                color: Colors.blue,
                                child: MaterialButton(
                                  onPressed: (){
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: widget.userModel.uid,
                                        dataTime: DateTime.now().toString(),
                                        text: textcontroller.text
                                    );
                                  },
                                  minWidth: 1,
                                  child: const Icon(Icons.send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback:(context)=> const Center(child: CircularProgressIndicator()),
                ),
              );
            },
          );
        }
    );
  }

  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
          model.text
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
          model.text
      ),
    ),
  );
}

