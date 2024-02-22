import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/add.dart';
import 'package:firebase_crud/service/database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream? DataStream;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _role = TextEditingController();
  getontheload() async {
    DataStream = await CRUD().getDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allData() {
    return StreamBuilder(
      stream: DataStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              
                              children: [
                                Text(
                                  "Name : " + ds["Name"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    _name.text = ds["Name"];
                                    _email.text = ds["Email"];
                                    _phone.text = ds["Phone_No"];
                                    _role.text = ds["Role"];

                                    editData(ds["Id"]);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                GestureDetector(
                                  onTap: ()async {
                                    await CRUD().deleteDetail(ds["Id"]);
                                  }
                                  ,child: Icon(Icons.delete,color: Colors.red,))

                              ],
                            ),
                            Text(
                              "Email : " + ds["Email"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              "Phone No : " + ds["Phone_No"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              "Role : " + ds["Role"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      },
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (cxt) => AddEmployee()));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(children: [Expanded(child: allData())]),
      ),
    );
  }


  Future editData(String id) => showDialog(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
                content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      "Annuity",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.blue),
                    ),
                    const Text(
                      "Risk",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.orange),
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
        
        //Form
                  Form(
                    key: _key,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
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
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _name,
                              decoration: const InputDecoration(
                                  hintText: "Enter Name",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter your Name";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _name.text = value!;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _email,
                              decoration: const InputDecoration(
                                  hintText: "Enter Email",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter your Email";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _email.text = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _phone,
                              decoration: const InputDecoration(
                                  hintText: "Enter Phone Number",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter your Phone Number";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _phone.text = value!;
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
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _role,
                              decoration: const InputDecoration(
                                  hintText: "Enter Role",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter your Role";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _role.text = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: ElevatedButton(
                                  onPressed: () async{
                                    Map<String,dynamic> updateMap = {
                                      "Name" : _name.text,
                                      "Email" : _email.text,
                                      "Phone_No" : _phone.text,
                                      "Role" : _role.text,
                                      "Id" : id
                                    };
                                    await CRUD().updateDetail(id, updateMap).then((value) => Navigator.pop(context));
                  
                                  }, child: Text("Update")))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ));
}
