import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_example/EditEmployee.dart';
import 'package:sqflite_example/resources/DatabaseHelper.dart';

class ViewEmployeScreen extends StatefulWidget
{
  const ViewEmployeScreen({Key? key}) : super(key: key);

  @override
  State<ViewEmployeScreen> createState() => _ViewEmployeScreenState();
}

class _ViewEmployeScreenState extends State<ViewEmployeScreen>
{
  Future<List>? alldata;
  Future<List>getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getAllemployes();
    return data;
  }
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata=getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Employe"),
        ),
        body: FutureBuilder(
          future: alldata,
          builder: (context,snapshots)
          {
            if(snapshots.hasData)
            {
              if(snapshots.data!.length <=0 )
              {
                return Center(
                  child: Text("No Data"),
                );
              }
              else
              {
                return ListView.builder(
                  itemCount: snapshots.data!.length,
                  itemBuilder: (context,index)
                  {
                    return Container(
                      width: MediaQuery.of(context).size.width,

                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                      color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Column(
                        children: [
                          Text(snapshots.data![index]["employename"].toString()),
                          Text(snapshots.data![index]["description"].toString()),
                          Text( snapshots.data![index]["gender"].toString()),
                          Text( snapshots.data![index]["department"].toString()),
                          ElevatedButton(onPressed: () async{

                            var id = snapshots.data![index]["eid"].toString();
                           DatabaseHelper obj = new DatabaseHelper();
                           var status = await obj.deleteEmployes(id);
                           if(status==1)
                             {
                               setState(() {
                                 alldata=getdata();
                               });
                             }
                           else
                             {
                               print("Not Deleted");
                             }
                          }, child: Text("Delete")),

                          ElevatedButton(onPressed: (){
                            var id = snapshots.data![index]["eid"].toString();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>EditEmployee(
                                updateid: id,
                              ))
                            );
                          }, child: Text("Edit")),
                        ],
                      ),
                    );

                  },
                );
              }
            }
            else
            {
              return Center(
                  child: Text("Loading...")
              );
            }
          },
        ),
    );
  }
}
