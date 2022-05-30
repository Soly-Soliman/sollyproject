
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Components/components.dart';
import '../block/massages/cubitsocial.dart';
import '../block/massages/statesocial.dart';
import '../models/user.dart';
import 'ChatDetails.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( context )=>SocialCubit(),
      child: Builder(
        builder: (context){
          SocialCubit.get(context).getAllUsers();
          return  BlocConsumer<SocialCubit,SocialState>(
            listener: (context,state){},
            builder: (context,state){
              return ConditionalBuilder(
                 // condition: SocialCubit.get(context).users.isNotEmpty,
                condition: true,
                fallback: (context) => const Center(child: Text('this is not true')),
                builder: (context)=>ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
                    separatorBuilder: (context,index)=>lineavater(),
                    itemCount: SocialCubit.get(context).users.length),
                //  fallback: (context)=>Center(child: const CircularProgressIndicator()),

              );
            },
          ) ;
        },
      ),
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
            backgroundImage: NetworkImage(model.photoUrl),
          ),
          const SizedBox(width: 15.0,),
          Row(
            children:   [
              Text(model.username,style: const TextStyle(color: Colors.black,fontSize: 16.0),),
              const SizedBox(width: 5.0,),
            ],
          ),





        ],
      ),
    ),
  );
}

