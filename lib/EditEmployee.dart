import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_example/resources/DatabaseHelper.dart';

import 'ViewEmployeScreen.dart';
class EditEmployee extends StatefulWidget
{

  var updateid="";

  EditEmployee({required this.updateid});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  var selected = "sale";
  var gender = "male";

  getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getsingleemployee(widget.updateid);
    setState(() {
      _name.text = data[0]["employename"].toString();
      _description.text = data[0]["description"].toString();
      selected = data[0]["department"].toString();
      gender = data[0]["gender"].toString();
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 600,
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            color: Color(0xfffff3e0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0,),
                Text("Name"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Description"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _description,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Gender"),
                SizedBox(height: 15.0,),
                Row(
                  children: [
                    Radio(
                        value: "male",
                        groupValue: gender,
                        onChanged: (val){
                          setState(() {
                            gender=val!;
                          });
                        }
                    ),
                    Text("Male"),
                    SizedBox(width: 15.0,),
                    Radio(
                        value: "female",
                        groupValue: gender,
                        onChanged: (val){
                          setState(() {
                            gender=val!;
                          });
                        }
                    ),
                    Text("Female"),

                  ],
                ),
                SizedBox(height: 10.0,),
                Text("Department"),
                DropdownButton(
                  dropdownColor: Colors.orangeAccent.shade200,
                  value: selected,
                  onChanged: (val){
                    setState(() {
                      selected=val!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text("Sale"),
                      value: "sale",
                    ),
                    DropdownMenuItem(
                      child: Text("HR"),
                      value: "hr",
                    ),
                    DropdownMenuItem(
                      child: Text("Purchase"),
                      value: "purchase",
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                        var name = _name.text.toString();
                        var description = _description.text.toString();
                        var Gender = gender;
                        var department = selected;
                        DatabaseHelper obj= DatabaseHelper();
                        var status = await obj.updateEmployee(name,description,Gender,department,widget.updateid);
                        if(status==1)
                          {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ViewEmployeScreen())
                            );
                          }
                        else
                          {
                            print("Error");
                          }
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
