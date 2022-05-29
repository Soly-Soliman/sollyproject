import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Components/components.dart';
import '../block/massages/cubitsocial.dart';
import '../block/massages/statesocial.dart';
import '../models/user.dart';
import 'ChatDetails.dart';

class ChatsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(

      listener: (context,state){},
      builder: (context,state){
        return

          ConditionalBuilder(
        //  condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index)=>lineavater(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context)=>Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildChatItem(User model,context)=>InkWell(
    onTap: (){
      navigatto(context,ChatDetails(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.photoUrl}'),
          ),
          const SizedBox(width: 15.0,),
          Row(
            children:   [
              Text('${model.username}',style: TextStyle(color: Colors.black,fontSize: 16.0),),
              SizedBox(width: 5.0,),
            ],
          ),





        ],
      ),
    ),
  );
}
