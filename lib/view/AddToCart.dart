import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/databaseHelper.dart';
import '../model/Users.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("AddToCart",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
              return (snapshot.data![index].addToCart == 'true') ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 0.5,
                        offset: Offset(1,4)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${snapshot.data![index].name}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        ),
                        Text("${snapshot.data![index].quantity}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ) : Container();
            },);
          }
          return Container();
        },
      ),
    );
  }
}
