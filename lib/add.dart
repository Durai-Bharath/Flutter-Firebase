import 'package:flutter/material.dart';
import 'service/database.dart';
import 'package:random_string/random_string.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _name = "";
   String _email = "";
   String _phone = "";
   String _role = "";
void submitForm() async{
  if(_key.currentState!.validate()){
    _key.currentState!.save();
    String id = randomAlphaNumeric(10);
    Map<String,dynamic> map = {
      "Id" : id,
      "Name" : _name,
      "Email" : _email,
      "Phone_No" : _phone,
      "Role" : _role
    };
    await CRUD().addDetails(map,id);
    // .then((value){
    //   Fluttertoast.showToast(
    //     msg: "Added Successfully ",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
    // });
    
    print("Name : $_name");
    print("Email : $_email");
    print("Phone No : $_phone");
    print("Role : $_role");
    Navigator.pop(context);
    _key.currentState!.reset();
  }

}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Annuity",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.blue),
                ),
                Text(
                  "Risk",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.orange),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key : _key,
            child: Container(
              margin:const EdgeInsets.only(left: 20,right: 20,top: 20),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                        
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration:  const InputDecoration(hintText: "Enter Name",border: InputBorder.none) ,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter your Name";
                        }
                        return null;
                      },
                      onSaved: (value){
                        _name = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  const Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                        
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration:  const InputDecoration(hintText: "Enter Email",border: InputBorder.none) ,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter your Email";
                        }
                        return null;
                      },
                      onSaved: (value){
                        _email = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Phone Number",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                        
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration:  const InputDecoration(hintText: "Enter Phone Number",border: InputBorder.none) ,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter your Phone Number";
                        }
                        return null;
                      },
                      onSaved: (value){
                        _phone = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Role",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                        
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration:  const InputDecoration(hintText: "Enter Role",border: InputBorder.none) ,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter your Role";
                        }
                        return null;
                      },
                      onSaved: (value){
                        _role = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(child: ElevatedButton(onPressed: submitForm, child: Text("Submit")))
                ],
              ),
            ),
          ),
        ));
  }
}
