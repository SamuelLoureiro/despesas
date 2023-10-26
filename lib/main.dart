import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';
import 'models/transaction.dart';
import 'components/verba.dart';
import 'components/meta.dart';
import 'components/dados.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({Key? key}) : super(key: key);
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.amber,
          secondary: const Color.fromARGB(255, 12, 77, 14),
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          button: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Meta _meta = Meta(id: '1', value: 0);
  final List<Transaction> _transactions = [];
  Verba _verbainicial = Verba(id: '1', value: 0);
  double valueTotal = 0.0;
  String nome='Nome de usuário';
  String email='email@exemplo.com';

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    valueTotal += value;
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  addVerba(double value) {
    final newVerba = Verba(
      id: Random().nextDouble().toString(),
      value: value,
    );
    setState(() {
      _verbainicial = newVerba;
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  openVerbaForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return VerbaForm(addVerba);
      },
    );
  }

  addMeta(double value) {
    final newMeta = Meta(
      id: Random().nextDouble().toString(),
      value: value,
    );
    setState(() {
      _meta = newMeta;
    });
    Navigator.of(context).pop();
  }

  openMetaForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return MetaForm(addMeta);
      },
    );
  }
  _addDados(String name, String eemail) {
    setState(() {
      nome=name;
      email=eemail;
    });

    Navigator.of(context).pop();
  }

 _openDadosForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return DadosForm(_addDados);
    },
  );
  return; // Adicione este return aqui
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             UserAccountsDrawerHeader(
              accountName: Text('$nome'),
              accountEmail: Text('$email'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
            TextButton(
  onPressed: () {
    setState(() {
      _openDadosForm(context);
    });
  },
  child: Text('Alterar dados'),
),
            ListTile(
              title: Text('Salve dinheiro'),
              leading: Icon(Icons.save),
              onTap: () {
                // Adicione aqui a ação que deseja executar ao pressionar o item Salve dinheiro do menu
              },
              subtitle:Text('R\$ ${_meta.value-valueTotal}'),
            ),
            ListTile(
              title: Text('Meta da semana'),
              leading: Icon(Icons.flag),
              onTap: () => openMetaForm(context),
              subtitle: Text('R\$ ${_meta.value}'),
            ),
            ListTile(
              title: Text('Orçamento'),
              leading: Icon(Icons.attach_money),
              onTap: () => openVerbaForm(context),
              subtitle: Text('R\$ ${_verbainicial.value}'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
