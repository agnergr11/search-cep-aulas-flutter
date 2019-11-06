import 'dart:async';
import 'package:calculatorimc/services/via_cep_service.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return StreamBuilder(
    stream: bloc.darkThemeEnabled,
      initialData: false,
        builder: (context, snapshot) => MaterialApp(
          debugShowCheckedModeBanner: false,
            theme: snapshot.data ? ThemeData.dark() : ThemeData.light(),
              home: HomePage(snapshot.data)),
   );
   }
   }

class HomePage extends StatefulWidget {
  final bool darkThemeEnabled;
    HomePage(this.darkThemeEnabled);
      @override
      _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
final _formKey = GlobalKey<FormState>();

TextEditingController _searchCepController = TextEditingController();
TextEditingController _logradouroController = TextEditingController();
TextEditingController _complementoController = TextEditingController();
TextEditingController _bairroController = TextEditingController();
TextEditingController _localidadeController = TextEditingController();
TextEditingController _ufController = TextEditingController();
TextEditingController _unidadeCepController = TextEditingController();
TextEditingController _ibgeCepController = TextEditingController();
TextEditingController _giaController = TextEditingController();


  String _result;
  String _logradouro;
  String _complemento;
  String _bairro;
  String _localidade;
  String _uf;
  String _unidade;
  String _ibge;
  String _gia;

void resetFields() {
_searchCepController.text = '';
_logradouroController.text ='';
_complementoController.text ='';
_bairroController.text ='';
_ufController.text ='';
_ibgeCepController.text ='';
_giaController.text ='';
_localidadeController.text ='';
  }

void _showSnackbar(BuildContext context){
  var snackBar = SnackBar(
    content: Text("Cep não pode estar em branco")
  );
  Scaffold.of(context).showSnackBar(snackBar);
}

var list = ["one","two"];

@override
void initState() {
super.initState();
}

  @override
Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
            actions: <Widget>[
              
              IconButton(
                icon: Icon(Icons.share,
                  color: Colors.black,),
                     onPressed: () {
                        _showDialog();
                }
              ),
            ],
        title: Text("Consultar Cep",style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),),
      ),
     body: new SingleChildScrollView(
       padding: new EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, 
                children: <Widget>[
              buildform(context),
              buildSearchLogradouroTextField(),
              buildSearchLocalidadeTextField(),
              buildSearchComplementoTextField(),
              buildSearchEstadoTextField(),
              buildSearchUnidadeTextField(),
              buildSearchGuiaTextField(),
              buildSearchBairroTextField(),
              buildSearchIbgeTextField(),   
             _buildSearchCepButton(),  
                
        ],
        ),
        ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Dark Theme"),
              trailing: Switch(
                value: widget.darkThemeEnabled,
                onChanged: bloc.changeTheme,
              ),
            )
          ],
        ),
      ),
    );
  }

 Widget buildform(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on,),
          labelText: 'Cep',
          ), 
            validator: (value) {
              if (value.isEmpty) {
                _showSnackbar(context);
              }
              return null;
            },
            controller: _searchCepController,
          ),
        ],
      ),
    );
  }

  Widget  buildSearchLogradouroTextField(
  {TextEditingController controller, String error, String label}) {
  return TextFormField(
   
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
      prefixIcon: Icon(Icons.markunread_mailbox,),
      labelText: 'Logradouro',
      ), 
      controller:_logradouroController,
      );
      }

  Widget  buildSearchComplementoTextField(
  {TextEditingController controller, String error, String label}) {
      return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.add_circle,),
        labelText: 'Complemento',
        ), 
        controller: _complementoController,
        );
        }

  Widget  buildSearchBairroTextField(
  {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
      prefixIcon: Icon(Icons.home,),
      labelText: 'Bairro', 
      ), 
      controller: _bairroController,
      );
      }

  Widget  buildSearchLocalidadeTextField(
    {TextEditingController controller, String error, String label}) {
    return TextFormField(
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.location_city,),
    labelText: 'Cidade',
    ), 
    controller: _localidadeController
    );
  }

  Widget  buildSearchEstadoTextField(
    {TextEditingController controller, String error, String label}) {
    return TextFormField(
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.map,),
    labelText: 'Estado',     
    ), 
    controller: _ufController,
    );
    }

  Widget  buildSearchUnidadeTextField(
      {TextEditingController controller, String error, String label}) {
      return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
      prefixIcon: Icon(Icons.data_usage),
      labelText: 'Ibge',
      ), 
      controller: _ibgeCepController,
      validator: (text) {
      return text.isEmpty ? error : null;
      },
    );
  }

  Widget  buildSearchGuiaTextField(
    {TextEditingController controller, String error, String label}) {
    return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    prefixIcon: Icon(Icons.drag_handle,),
    labelText: 'Gia',
    ), 
    controller: _giaController,  
    );
    }

   Widget  buildSearchIbgeTextField(
   {TextEditingController controller, String error, String label}) {
   return TextFormField(
   keyboardType: TextInputType.number,
   decoration: InputDecoration(
   prefixIcon: Icon(Icons.format_underlined,),
   labelText: 'Unidade',
   ), 
   controller: _unidadeCepController,  
   ); 
   }

Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        child: Text('Pesquisar'),
        onPressed: (){ 
           if (_formKey.currentState.validate()) {
          _searchCep();
          _showSnackbar(context);
           }
        }
      ),
    );
  }

  void _searching(bool enable) {
    
      _result = enable ? '' : _result;     
      _logradouro= enable ? '' : _logradouro;
      _complemento = enable ? '' :_complemento;
      _bairro= enable ? '' :_bairro;
      _localidade = enable ? '' :_localidade;
      _uf = enable ? '' :_uf;
      _unidade= enable ? '' :_unidade;
      _ibge = enable ? '' :_ibge;
      _gia= enable ? '' :_gia;
    
  }

   Future _searchCep () async {
    _searching(true);

    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal

    _result = resultCep.cep;
      _logradouroController.text = resultCep.logradouro;
      _complementoController.text = resultCep.complemento;
      _bairroController.text = resultCep.bairro;
      _localidadeController.text = resultCep.localidade;
      _ufController.text = resultCep.uf;
      _unidadeCepController.text = resultCep.unidade;
      _ibgeCepController.text = resultCep.ibge;
      _giaController.text = resultCep.gia;

    _searching(false);
  }



 void _showDialog (
      {String title, String message, Function confirm, Function cancel}) async {
        _searching(true);

     final cep = _searchCepController.text;
    final resultCep = await ViaCepService.fetchCep(cep: cep);
    
      _result = resultCep.cep;
      _logradouro = resultCep.logradouro;
      _complemento = resultCep.complemento;
      _bairro = resultCep.bairro;
      _localidade = resultCep.localidade;
      _uf = resultCep.uf;
      _unidade = resultCep.unidade;
      _ibge = resultCep.ibge;
      _gia = resultCep.gia;

    _searching(false);


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
      return AlertDialog(
      title: Text('Compartilhar',
      textAlign: TextAlign.center, 
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
      ),
      ),
      content: Text( 'Cep : $_result\nLocalidade: $_localidade\nBairro $_bairro\nLogradouro: $_logradouro\nComplemento: $_complemento\nIbge: $_ibge\nEstado: $_uf\nGia: $_gia' ?? '' ,
      textAlign: TextAlign.start, 
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      ),
      actions: <Widget>[     
      FlatButton(
      child: Text("CANCEL",
      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
      ),
      onPressed: () {               
      Navigator.of(context).pop();
      if (cancel != null) cancel();
      },
      ),
      FlatButton(
      child: Icon(Icons.share, color: Colors.yellowAccent),
      onPressed: () {
      Share.share('Cep : $_result\nLocalidade: $_localidade\nBairro $_bairro\nLogradouro: $_logradouro\nComplemento: $_complemento\nIbge: $_ibge\nEstado: $_uf\nGia: $_gia\n Unidade: $_unidade' ?? '');
      Navigator.of(context).pop();
      if (confirm != null) confirm();
      },
      ),           
      ],
      );
      },
    );
  }
   
}
class Bloc {

final _themeController = StreamController<bool>();
get changeTheme => _themeController.sink.add;
get darkThemeEnabled => _themeController.stream;

}

final bloc = Bloc();




