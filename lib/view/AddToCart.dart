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
            return GridView.builder(
              itemCount:snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5/6
              ),
              itemBuilder: (context,index){
                return (snapshot.data![index].addToCart == 'true ') ? Padding(
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
                      ],
                    ),
                  ),
                ) : Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
