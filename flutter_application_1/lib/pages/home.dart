import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'filter.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _userToDo;
  List todoList = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  // Pagina care poate sa nu fie nevoie
  void _menuOpen(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return Scaffold(
          appBar: AppBar(title: Text('Menu'),
          centerTitle: true,
          ),
          body: Row(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }, 
              child: Text('To main')),
              Padding(padding: EdgeInsets.only(left: 20)),
              Text('Simple menu'),
            ],
          )
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined), //onPressed: _menuOpen,
            onPressed: (){
              FirebaseFirestore.instance.collection('items')
                .orderBy('item',descending: false)
                .orderBy('item');
            },
          ),
        ],
        title: Text(
          'ITEMS',
          style: TextStyle(
            fontFamily: "Times New Roman",
          )
          ),
      ), 
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) {
            return Container(
              child: Text("Waiting for data")
            );
          }
          return ListView.builder(
            
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext_context, int index){
            return Dismissible(// merge in combinatie cu onDismissed (functional pentru card ca sal poti sterge din UI)
              key: Key(snapshot.data!.docs[index].id),  
              child: Card(
                child: ListTile(

                  // AFISAREA INFORMATIEI DESPRE ITEM ON TAP
                onTap: (){
                showDialog(context: context, builder: (BuildContext context){ //vsplivaiushee okno
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                
                "Denumirea: " + snapshot.data!.docs[index].get('item')+
                "\nCantitatea: " + snapshot.data!.docs[index].get('item')+
                "\nPozitia: " + snapshot.data!.docs[index].get('item') ,
          
                style: TextStyle(
                 fontFamily: "Times New Roman", 
                ),),
        
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context, 'Cancel');
                },
                child: Text('Inchide')
                ),
              ],
            );
          });
                },

                  title: Text(snapshot.data!.docs[index].get('item')),
                  trailing: IconButton(
                  icon: Icon(
                    Icons.delete_sweep,
                    color: Colors.red,
                    ),
                    onPressed: () {

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        title: Text('Doriti sa stergeti?', style: TextStyle(fontFamily: 'Times New Roman')),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Nu', style: TextStyle(fontSize: 20, fontFamily: "Times New Roman")),
                          ),
                          TextButton(
                             onPressed: () => [Navigator.pop(context, 'Cancel'), FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete()],
                            child: const Text('Da', style: TextStyle(fontSize: 20, fontFamily: "Times New Roman")),
                          ),
                        ],
                      )
                    );


                      // FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                    },
                  ),
                ),
              ),
            onDismissed: (direction) {
              FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
            },
          );
        }
        );
        }        
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context){ //vsplivaiushee okno
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'ADD ITEM',
                style: TextStyle(
                 fontFamily: "Times New Roman", 
                ),),
              content: TextField(
                onChanged: (String value) {
                  _userToDo = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: (){
                  FirebaseFirestore.instance.collection('items')
                    .add({'item': _userToDo}
                    ); //adaugare
                  Navigator.of(context).pop();
                },
                child: Text('ADD')),
              ],
            );
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),),
    );
  }
}