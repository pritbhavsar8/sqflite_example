import 'package:flutter/material.dart';
import 'package:sqflite_example/resources/DatabaseHelper.dart';

class AddProductScreen extends StatefulWidget
{
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
{
  
  var selected = "electronic";
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
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
                Text("Title"),
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
                    maxLines: 2,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Price"),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Category"),
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
                      child: Text("Electronic"),
                      value: "electronic",
                    ),
                    DropdownMenuItem(
                      child: Text("Beauty"),
                      value: "beauty",
                    ),
                    DropdownMenuItem(
                      child: Text("Grocery"),
                      value: "grocery",
                    ),
                    DropdownMenuItem(
                      child: Text("Pharmacy"),
                      value: "pharmacy",
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                       ElevatedButton(
                        onPressed: () async{

                          var title  = _name.text.toString();
                          var description  = _description.text.toString();
                          var price  = _price.text.toString();
                          var category = selected;

                          DatabaseHelper obj = new DatabaseHelper();
                          var id = await obj.addproduct(title,description,price,category);
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
