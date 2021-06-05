import 'package:flutter/material.dart';
import 'HttpHandler.dart';

void main() => runApp(MaterialApp(home:FruitApp()));

class FruitApp extends StatefulWidget {
  @override
  _FruitAppState createState() => _FruitAppState();
}

class _FruitAppState extends State<FruitApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fruit app'),
        ),

        body: Container(
          margin: EdgeInsets.all(13.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 9.0, bottom: 9.0),
                child: Center(
                  child: const Text('Fruit List', style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: HttpHandler.getFruit(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      print('snapshot $snapshot');
                      if(snapshot.connectionState == ConnectionState.done){

                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              return ListTile(
                                title: Text(snapshot.data[index].fruit),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_right),
                                  onPressed: () async{
                                    // add do something
                                  },
                                ),

                                subtitle: Text('Vitamins: ${snapshot.data[index].vitamin}'),

                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 44,
                                    maxHeight: 44,
                                  ),
                                  child: Image.network(snapshot.data[index].pic),
                                ),
                              );
                            });
                      }else{
                        return Align(child: CircularProgressIndicator(),);
                      }
                    }
                ),
              ),
            ],
          ),
        )
    );
  }
}
