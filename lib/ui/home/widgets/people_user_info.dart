import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "add you image URL here "
                        ),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0,2.25),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "Add you profile DP image URL here "
                      ),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 80,
              ),
              Text(
                "Hung Nguyen Manh"
                ,style: TextStyle(
                  fontSize: 30.0,
                  color:Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400
              ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "   Note"
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              TextFormField(initialValue: "Add Note"),
              // ListTile(
              //   leading: Icon(Icons.note),
              //   title: Text('Add Note'),
              // ),
              SizedBox(
                height: 40,
              ),
              Text(
                "   Notifications"
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              // Card(
              //     margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              //
              //     elevation: 2.0,
              //     child: Padding(
              //         padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
              //         child: Text("Email",style: TextStyle(
              //             letterSpacing: 2.0,
              //             fontWeight: FontWeight.w300
              //         ),))
              // ),

              ListTile(
                leading: Icon(Icons.mail),
                title: Text('Email'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "   Classes Joined"
                ,style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
              ),
              ListTile(
                leading: Icon(Icons.room),
                title: Text('Class 1'),
              ),
              ListTile(
                leading: Icon(Icons.room),
                title: Text('Class 2'),
              ),

              // SizedBox(
              //   height: 15,
              // ),
              // Text(
              //   "Note"
              //   ,style: TextStyle(
              //     fontSize: 18.0,
              //     color:Colors.black45,
              //     letterSpacing: 2.0,
              //     fontWeight: FontWeight.w300
              // ),
              // ),

              // Card(
              //   margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Expanded(
              //           child: Column(
              //             children: [
              //               Text("Project",
              //                 style: TextStyle(
              //                     color: Colors.blueAccent,
              //                     fontSize: 22.0,
              //                     fontWeight: FontWeight.w600
              //                 ),),
              //               SizedBox(
              //                 height: 7,
              //               ),
              //               Text("15",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 22.0,
              //                     fontWeight: FontWeight.w300
              //                 ),)
              //             ],
              //           ),
              //         ),
              //         Expanded(
              //           child:
              //           Column(
              //             children: [
              //               Text("Followers",
              //                 style: TextStyle(
              //                     color: Colors.blueAccent,
              //                     fontSize: 22.0,
              //                     fontWeight: FontWeight.w600
              //                 ),),
              //               SizedBox(
              //                 height: 7,
              //               ),
              //               Text("2000",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 22.0,
              //                     fontWeight: FontWeight.w300
              //                 ),)
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // SizedBox(
              //   height: 50,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     RaisedButton(
              //       onPressed: (){
              //
              //       },
              //       shape:  RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(80.0),
              //       ),
              //       child: Ink(
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //               begin: Alignment.centerLeft,
              //               end: Alignment.centerRight,
              //               colors: [Colors.pink,Colors.redAccent]
              //           ),
              //           borderRadius: BorderRadius.circular(30.0),
              //
              //         ),
              //         child: Container(
              //           constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "Contact me",
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 12.0,
              //                 letterSpacing: 2.0,
              //                 fontWeight: FontWeight.w300
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     RaisedButton(
              //       onPressed: (){
              //
              //       },
              //       shape:  RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(80.0),
              //       ),
              //       child: Ink(
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //               begin: Alignment.centerLeft,
              //               end: Alignment.centerRight,
              //               colors: [Colors.pink,Colors.redAccent]
              //           ),
              //           borderRadius: BorderRadius.circular(80.0),
              //
              //         ),
              //         child: Container(
              //           constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "Portfolio",
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 12.0,
              //                 letterSpacing: 2.0,
              //                 fontWeight: FontWeight.w300
              //             ),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        )
    );
  }
}