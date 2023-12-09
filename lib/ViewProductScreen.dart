import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_example/resources/DatabaseHelper.dart';

class ViewProductScreen extends StatefulWidget
{
  const ViewProductScreen({Key? key}) : super(key: key);

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen>
{

  Future<List>? alldata;

  Future<List> getdata() async
  {
    DatabaseHelper obj = new DatabaseHelper();
    var data = await obj.getAllProducts();
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   setState(() {
     alldata = getdata();
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Product"),
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
                        color: Colors.red.shade100,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(snapshots.data![index]["productname"].toString()),
                            Text(snapshots.data![index]["description"].toString()),
                            Text("Rs. " + snapshots.data![index]["price"].toString()),
                            Text(snapshots.data![index]["category"].toString()),
                            ElevatedButton(onPressed: () async {

                              var id = snapshots.data![index]["pid"].toString();
                               var obj =   DatabaseHelper();
                              var status= await obj.deleteProducts(id);
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
                            ElevatedButton(onPressed: (){}, child: Text("Edit")),
                          ],
                        ),
                      );
                      // return ListTile(
                      //   title: Text(snapshots.data![index]["productname"].toString()),
                      //   subtitle: Text(snapshots.data![index]["category"].toString()),
                      //   trailing:Text("Rs. " + snapshots.data![index]["price"].toString()),
                      // );
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
