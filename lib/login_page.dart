import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image(image: AssetImage("/img/logo_iflab.png"), width: 150,),
              SizedBox(height: 10,),
              Text("Attendance System", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
              Text("Sistem Presensi Asisten Laboratorium Informatika", style: TextStyle(fontSize: 16),),
              SizedBox(height: 30,),
          
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Akun email", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email_outlined, color: Colors.blueGrey,),
                        hintText: "asprak@iflab.ac.id",
                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Color(0xFFEFEFFF),
                      ),
                    ),
                    SizedBox(height: 20,),
          
                    Text("Password", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.blueGrey,),
                        hintText: "********",
                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Color(0xFFEFEFFF),
                      ),
                    ),
                    SizedBox(height: 50,),
          
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF1E40AF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        minimumSize: Size.fromHeight(60)
                      ),
                      
                      child: Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Text("Developed by Izin Kompe", style: TextStyle(color: Colors.blueGrey),)
        ],
      ),
    );
  }
}
