import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prexam/model/Users.dart';

import '../controller/databaseHelper.dart';

class HomeData extends StatefulWidget {
  const HomeData({Key? key}) : super(key: key);

  @override
  State<HomeData> createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeData> {

  DatabaseHelper dbHelper = DatabaseHelper.instance;
  TextEditingController textEditingController = TextEditingController();
  int value = 0;
   Widget? varData;
  DateTime now = DateTime.now();
 Duration duration = Duration(seconds: 30);

  // TimerData(){
  //   value = now.minute;
  //   // Timer.periodic(Duration(seconds: 1), (Timer t) {
  //   //   setState(() {
  //   //
  //   //     value++;
  //   //     if(value<= 30){
  //   //
  //   //     else
  //   //       {
  //   //         varData = Text("Lalla kuch nahi");
  //   //       }
  //   //   });
  //   // });
  //   // Timer(Duration(seconds: 30), () {
  //   //   print("Yeah, this line is printed after 3 seconds");
  //   // });
  //   Future.delayed(Duration(seconds: 10) , (){
  //     value++;
  //    if(value <= 30){
  //      varData = FutureBuilder(
  //                  future: dbHelper.retrieveUsers(),
  //                  builder: (context,snapshot){
  //                    if(snapshot.hasError){
  //                      print("error");
  //                    }
  //                    else if(snapshot.connectionState == ConnectionState.waiting){
  //                      return Center(
  //                        child: CircularProgressIndicator(),
  //                      );
  //                    }
  //                    else
  //                    {
  //                      return GridView.builder(
  //                        itemCount:snapshot.data!.length,
  //                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                            crossAxisCount: 2,
  //                            childAspectRatio: 5/6
  //                        ),
  //                        itemBuilder: (context,index){
  //                          return Padding(
  //                            padding: const EdgeInsets.all(8.0),
  //                            child: Container(
  //                              decoration: BoxDecoration(
  //                                color: Colors.white,
  //                                boxShadow: [
  //                                  BoxShadow(
  //                                      color: Colors.grey,
  //                                      blurRadius: 0.5
  //                                  ),
  //                                ],
  //                              ),
  //                              child: Column(
  //                                children: [
  //                                  Text("${snapshot.data![index].name}"),
  //                                  Text("${snapshot.data![index].quantity}"),
  //                                  Text("${snapshot.data![index].addToCart}")
  //                                ],
  //                              ),
  //                            ),
  //                          );
  //                        },
  //                      );
  //                    }
  //                    return Container();
  //                  },
  //                );
  //
  //    }
  //    else
  //      {
  //        varData = Text("Lalla kuch nahi");
  //      }
  //   });
  // }
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TimerData();
    print("data ${value}");
  }

  // TimerData(){
  //   Timer(duration, () {
  //     setState(() {
  //       (duration == 5) ? HomeData() : OutStockLabel();
  //       print(duration);
  //     });
  //   });
  // }


  TimerData(){
    Timer(duration, () {
      setState(() {
        if (duration == 5) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeData()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OutStockLabel()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //TimerData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HomePage",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, 'addToCart');
          }, icon: Icon(Icons.shopping_bag_outlined)),
        ],
      ),


      body: FutureBuilder(
          future: dbHelper.retrieveUsers(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              print("error");
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else
            {
              return GridView.builder(
                itemCount:snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5/6
                ),
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text("${snapshot.data![index].name}"),
                          Text("${snapshot.data![index].quantity}"),
                          Text("${snapshot.data![index].addToCart}"),
                          SizedBox(height: 100,),
                          GestureDetector(
                            onTap: () async {

                                if(snapshot.data![index].addToCart == 'false'){
                                  snapshot.data![index].addToCart = 'true';
                                }
                                else{
                                  snapshot.data![index].addToCart = 'false';
                                }
                                final data = User(name: snapshot.data![index].name, quantity: snapshot.data![index].quantity, addToCart:snapshot.data![index].addToCart);
                                await dbHelper.updataStatic(user: data,id: '1',table: DatabaseHelper.tableName);
                                print("add to cart ${1}");

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                alignment: Alignment.center,
                                child: Text("Add To Cart",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        )

    );
  }
}


// Column(
// children: [
// TextFormField(
// controller: textEditingController,
// decoration: InputDecoration(
// enabledBorder: OutlineInputBorder(),
// focusedBorder: OutlineInputBorder(),
// ),
// ),
// CupertinoButton(
// child: Text("Add Data"),
// onPressed: () async {
// final data = User(name: textEditingController.text, quantity: '1', addToCart: 'false');
// final isInserted = await dbHelper.insert(data);
// print("Data Add $isInserted");
// },
// ),
// ],
// ),

//================== stat

class OutStockLabel extends StatefulWidget {
  const OutStockLabel({Key? key}) : super(key: key);

  @override
  State<OutStockLabel> createState() => _OutStockLabelState();
}

class _OutStockLabelState extends State<OutStockLabel> {

  DatabaseHelper dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Container(),
          title: Text("HomePage",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, 'addToCart');
            }, icon: Icon(Icons.shopping_bag_outlined)),
          ],
        ),
        body: FutureBuilder(
          future: dbHelper.retrieveUsers(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              print("error");
            }
            else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else
            {
              return GridView.builder(
                itemCount:snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5/6
                ),
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text("${snapshot.data![index].name}"),
                          Text("${snapshot.data![index].quantity}"),
                          Text("${snapshot.data![index].addToCart}"),
                          SizedBox(height: 100,),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              alignment: Alignment.center,
                              child: Text("Out Of Stock",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        )
    );
  }
}



// Column(
// children: [
// TextFormField(
// controller: textEditingController,
// decoration: InputDecoration(
// enabledBorder: OutlineInputBorder(),
// focusedBorder: OutlineInputBorder(),
// ),
// ),
// CupertinoButton(
// child: Text("Add Data"),
// onPressed: () async {
// // Map<String,dynamic> data = {
// // DatabaseHelper.columnName : textEditingController.text,
// // DatabaseHelper.columnQua : '1',
// // DatabaseHelper.columnAdd : 'false'
// // };
// final data = User(name: textEditingController.text, quantity: '1', addToCart: 'false');
// final isInserted = await dbHelper.insert(data);
// print("Data Add $isInserted");
// },
// ),
// ],
// )