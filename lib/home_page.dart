import 'package:flutter/material.dart';
import 'package:listview_animado/usuario_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _listKey1 = GlobalKey();
  GlobalKey<AnimatedListState> _listKey2 = GlobalKey();
  List<UsuarioModel> usuarios = [
    UsuarioModel(nome: 'Rodrigo', url: 'https://i.pinimg.com/originals/85/45/81/854581580a300a561e5146ced943ccb7.jpg'),
    UsuarioModel(nome: 'João', url: 'https://conteudo.imguol.com.br/c/entretenimento/38/2019/10/16/o-coringa-de-rousseau-o-homem-nasce-livre-e-por-toda-a-parte-encontra-se-a-ferros-1571252808188_v2_1280x720.jpg'),
    UsuarioModel(nome: 'José', url: 'https://uploads.metropoles.com/wp-content/uploads/2019/04/03170659/Heath-Ledger-Coringa-RED.jpg'),
  ];

  List<UsuarioModel> lista1 = [];
  List<UsuarioModel> lista2;

  @override
  void initState() {
    super.initState();
    lista2 ??= usuarios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
              child: AnimatedList(
                key: _listKey1,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                initialItemCount: lista1.length,
                itemBuilder: (context, index, animation) => _buildItemList1(index, lista1[index], animation),
              ),
            ),
            Expanded(
              child: AnimatedList(
                key: _listKey2,
                initialItemCount: lista2.length,
                shrinkWrap: true,
                itemBuilder: (context, index, animation) => _buildItemList2(index, lista2[index], animation),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemList1(int index, UsuarioModel usuario, Animation animation) {
    return FadeTransition(
      key: UniqueKey(),
      opacity: animation,
      child: InkWell(
        onTap: () => removeList1(index),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(usuario.url),
            radius: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildItemList2(int index, UsuarioModel usuario, Animation animation) {
    return FadeTransition(
      key: UniqueKey(),
      opacity: animation,
      child: ListTile(
          onTap: () => removeList2(index),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(usuario.url),
          ),
          title: Text(usuario.nome)),
    );
  }

  void removeList2(int index) {
    var usuario = lista2[index];
    _listKey2.currentState.removeItem(
      index,
      (context, animation) => _buildItemList2(index, usuario, animation),
      duration: Duration(milliseconds: 300),
    );
    lista2.removeAt(index);

    lista1.add(usuario);
    _listKey1.currentState.insertItem(lista1.length - 1, duration: Duration(milliseconds: 300));
  }

  removeList1(int index) {
    var usuario = lista1[index];
    _listKey1.currentState.removeItem(
      index,
      (context, animation) => _buildItemList1(index, usuario, animation),
      duration: Duration(milliseconds: 300),
    );
    lista1.removeAt(index);

    lista2.add(usuario);
    _listKey2.currentState.insertItem(lista2.length - 1, duration: Duration(milliseconds: 300));
  }
}
