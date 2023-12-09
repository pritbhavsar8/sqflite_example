import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_example/resources/DatabaseHelper.dart';

class AddEmployeScreen extends StatefulWidget
{
  const AddEmployeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeScreen> createState() => _AddEmployeScreenState();
}

class _AddEmployeScreenState extends State<AddEmployeScreen>
{
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  var selected = "sale";
  var gender = "male";
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
                        var id = await obj.addemploye(name,description,Gender,department);

                        print("Record Inserted at : "+id.toString());
                      },
                      child: Text("Add"),
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
