import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
   @override
  _HomePage createState() =>
      _HomePage();
}
class _HomePage extends State<HomePage> {
  late Future<List<dynamic>> task;
    late Future<List<TaskListData>>  future;

 
late List<TaskListData> _foundUsers;
  late int listCount; 
  
 List<dynamic> _searchResult = [];
 
 
   List<TaskListData> _userDetails = [];
     TextEditingController controller = new TextEditingController();

  final ScrollController _scrollController = ScrollController();

     @override
  void initState() {
     
    super.initState();
    future = getUserDetails();
  }
 
  Future<List<TaskListData>> getUserDetails() async {
    
    final response = await http.get(
      Uri.parse("https://reqres.in/api/users?pages=2"),
      headers: {
        "Content-Type": "application/json" 
      },
    );
    final responseJson = json.decode(response.body)['data'];
    print("respnse:" + responseJson.toString());
    var list = responseJson.length;
    
    listCount = list;
    print("Listcount" + listCount.toString());
    setState(() {
      for (Map<String, dynamic> user in responseJson) {
        _userDetails.add(TaskListData.fromJson(user));
        _foundUsers=_userDetails;
      }
    });
     
    
    return _foundUsers;
  }




  onSearchTextChanged(String text) async {
    _searchResult.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((dynamic userDetail) {
      if (userDetail.id.toString().toLowerCase().contains(text) ||
          userDetail.first_name.toString().toLowerCase().contains(text)||
          userDetail.last_name.toString().toLowerCase().contains(text)||userDetail.email.toString().toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }


 Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                     onChanged: onSearchTextChanged,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                     decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search",
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
               borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                  ),
              ),
            ),
          ),
      )],
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Consagous Task"),
      ),
      body:  

             FutureBuilder(
        future: future,
        builder: (context, AsyncSnapshot snapshot) {
          print("data found");

          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:   Column(children: [ 
          getSearchBarUI(),
Expanded(child: 
_searchResult.length != 0 || controller.text.isNotEmpty
              ? new ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: _searchResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new  Card(
                                  child: ListTile(
                                minVerticalPadding: 10,
                                subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(children: [
                                                 Padding(padding: const EdgeInsets.all(2.0),
                                                 child:   CircleAvatar(backgroundColor: Colors.blueAccent,
    radius: 37,
    child:   CircleAvatar(radius: 35,
    backgroundImage:NetworkImage(_searchResult[index].avatar) ,
    backgroundColor: Colors.white, 
    
    ),),),
   

                                     
                                    ]),
                                      Padding(
                                          padding: EdgeInsets.only(right: 10)),
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                               "Id: "+  _searchResult[index].id.toString() ,
                                                 style: TextStyle(fontSize: 14),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                          
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5)),
                                              Text(
                                                 "First Name: "+  _searchResult[index].first_name.toString() 
                                                ,style: TextStyle(fontSize: 14),
                                              ),  Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5)),
                                              Text(
                                                 "Last Name: "+  _searchResult[index].last_name.toString() 
                                                ,style: TextStyle(fontSize: 14),
                                              ),
                                                  Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5)),
                                              Text(
                                                "Email: "+  _searchResult[index].email.toString() ,
                                              style: TextStyle(fontSize: 14),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                                  Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20)),
                                               
                                            ]),
                                      ),
                                    ]),
                                 
                                contentPadding: EdgeInsets.all(5.0),
                              ));
                  },
                )
              :  SingleChildScrollView(
                    //  scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      child: Container(
                          height: MediaQuery.of(context).size.height  ,
                          child: new ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(8),
                            itemCount: _userDetails.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  child: ListTile(
                                minVerticalPadding: 10,
                                subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(children: [

                                        
                                         Padding(padding: const EdgeInsets.all(2.0),
    

    child:   CircleAvatar(backgroundColor: Colors.blueAccent,
    radius: 37,
    child:   CircleAvatar(radius: 35,
    backgroundImage:NetworkImage(_userDetails[index].avatar) ,
    backgroundColor: Colors.white, 
    
    ),),),
   
 
                                    ]),
                                      Padding(
                                          padding: EdgeInsets.only(right: 10)),
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                               "Id: "+  _userDetails[index].id.toString() ,
                                                 style: TextStyle(fontSize: 14),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                          
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5)),
                                              Text(
                                                 "First Name: "+  _userDetails[index].first_name.toString() 
                                               ,style: TextStyle(fontSize: 14),
                                              ),  Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5)),
                                              Text(
                                                 "Last Name: "+  _userDetails[index].last_name.toString() 
                                              , style: TextStyle(fontSize: 14),
                                              ),
                                                  Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5)),
                                              Text(
                                                "Email: "+  _userDetails[index].email.toString() ,
                                             style: TextStyle(fontSize: 14),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                                  Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20)),
                                               
                                            ]),
                                      ),
                                    ]),
                                 
                                contentPadding: EdgeInsets.all(5.0),
                              ));
                             
                            
                          
                          
                            },
                          ))))]));
              

     
     
  }));
        }  
    
       
        
  }





class TaskListData {
  final dynamic id;
  final dynamic email;
  final dynamic first_name;
  final dynamic last_name;
  final dynamic avatar; 

  TaskListData(
      {this.id,
      this.email,
      this.first_name,
      this.last_name,
      this.avatar
       });

  factory TaskListData.fromJson(Map<String, dynamic> json) {
    return TaskListData(
      id: json['id'] as dynamic,
      email: json['email'] as dynamic,
      first_name: json['first_name'] as dynamic,
      last_name: json['last_name'] as dynamic,
      avatar: json['avatar'] as dynamic 
    );
  }

  static List<TaskListData> taskList = <TaskListData>[
    TaskListData(
      id: 'id' as dynamic,
      email: 'email' as dynamic,
      first_name: 'first_name' as dynamic,
      last_name: 'last_name' as dynamic,
      avatar: 'avatar' as dynamic,
      
    ),
  ];
 
}
