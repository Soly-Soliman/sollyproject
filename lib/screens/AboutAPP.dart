import 'package:flutter/material.dart';

import '../Utils/colors.dart';



class About extends StatelessWidget{
  const About({Key?key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('About US'),
        backgroundColor: selection,
        foregroundColor: primary,

      ),
      backgroundColor: blue1,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Dr: Mai eldafrawy',
                            style: TextStyle(
                              fontSize: 30,
                            ),

                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0,),
                            color: Colors.grey.shade400,

                          ),
                          child: Column(
                            children: [
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://scontent.fcai19-3.fna.fbcdn.net/v/t39.30808-6/257519657_1701296376733077_3716489816494877546_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHAABM9D1pgkY7l-bH0_HFoseAgtqZYPh6x4CC2plg-HmIyWzOOg2FxvPIaug-NxaBvvcYLdbxMvcBQSriYrFMm&_nc_ohc=ohF93afXcVYAX8554Lq&_nc_ht=scontent.fcai19-3.fna&oh=00_AT9LgEceD_qxmMKJUlbH3GugE3lI5J5B7nM1JtxdcU4zCQ&oe=62AD6ED6'),
                              ),
                              SizedBox(
                                width: 15,
                              ),

                              Column(
                                children: [
                                  Text(
                                    'Team Leader',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),

                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Mohamed Soliman',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://scontent.fcai19-3.fna.fbcdn.net/v/t1.6435-9/192229596_1464338057231842_1163602124595505408_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=174925&_nc_eui2=AeE12RYVJ2fzX235prv1DHzuXeEl72hxCmFd4SXvaHEKYa66tMHeDQCbqlyMcaNx4FmhoZAC_rNKpyzmHLihLF_r&_nc_ohc=y5vs6XThY1sAX8nJjsR&_nc_ht=scontent.fcai19-3.fna&oh=00_AT_mtKc-2_AwO-I8eThHzgqyyqkZlAEBei04LfChz9jIxA&oe=62CDF2FF'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Mohamed Ahmed ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),

                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://scontent.fcai19-3.fna.fbcdn.net/v/t1.6435-9/69257813_2435017813489922_6836316878315454464_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=174925&_nc_eui2=AeHZMwFuAiLEJYK6lpWdaOwEjbKMbWscf86Nsoxtaxx_zqYvIEuJJkf1oBuIItsSo5VzvhnuJUrj_NLAtZh7ZzUA&_nc_ohc=CIt8cgFTRFQAX_ye1cX&_nc_ht=scontent.fcai19-3.fna&oh=00_AT_GJ2iAqxWAJZaduUcKqgVga2L41YBNQeqoRP8LTLFVfg&oe=62CE4459'),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                'Ahmed Gamal   ',
                                style: TextStyle(
                                  fontSize: 22,
                                ),

                              ),
                            ],
                          ),
                        ),


                        SizedBox(
                          height: 20,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://scontent.fcai19-3.fna.fbcdn.net/v/t39.30808-6/283690937_521984572907064_2345699981825085290_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFfbN2SSv-myIdmuhnrnopjdDmcgQ1Z7RJ0OZyBDVntEvkMZCAe0L-Elv0SdKBwcL9J2RH0oaE3Qbsu69Ytdhup&_nc_ohc=S0-4HO7556AAX_5CEa6&_nc_ht=scontent.fcai19-3.fna&oh=00_AT-m9S1Trn1IeSVgPgHLfwqybK7ovS-VUSF7xUAYGKs9dA&oe=62AC925F'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Mohamed Mostafa',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),

                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://scontent.fcai19-3.fna.fbcdn.net/v/t39.30808-6/279769429_1040615783542111_6458288602812172291_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEdL63aPnKEg2xEBgp0LF7uCcWuAkpHejQJxa4CSkd6NAzoR981dHZ6SMkHFIDNrD__rh50UhKt4ZIGguFv2Q6q&_nc_ohc=M1VOVfyeHGEAX8RXR88&_nc_ht=scontent.fcai19-3.fna&oh=00_AT-aj-1_gir2wRRBLZQ4MOWLsor13Jp96yRDwnm2ku-TSA&oe=62ADC558'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Mohamoud Mohamed',
                                style: TextStyle(
                                  fontSize: 18,
                                ),

                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage('https://scontent.fcai19-3.fna.fbcdn.net/v/t39.30808-6/279541656_723273915378336_9202390472438912243_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeG_vS2AgTrsPCP32p0sqiS9SOyFmwLgLL5I7IWbAuAsviK7EA2sWw2c5T6YxYd1Xit08HK-daKXalJA-77CtfuY&_nc_ohc=xbdPegb0VRoAX8dFfP2&_nc_ht=scontent.fcai19-3.fna&oh=00_AT-nTBJnpqaaauBonBR3vRpAYQTFPugDR7Inhc5G9LY2Zg&oe=62AD0925'),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Mohamed Nageh',
                                style: TextStyle(
                                  fontSize: 21,
                                ),

                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),


    );
  }}