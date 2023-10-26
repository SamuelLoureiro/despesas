// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class DadosForm extends StatefulWidget {
  final void Function(String,String) onSubmit;

  const DadosForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  _MetaFormState createState() => _MetaFormState();
}

class _MetaFormState extends State<DadosForm> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
 
  _submitForm() {
    final nome = _nomeController.text;
    final email= _emailController.text;   
    if (nome.isEmpty || email.isEmpty) {
      return;
    }

    widget.onSubmit(nome,email);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
              ),
            ),
            TextField(
              controller: _emailController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'e-mail',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button?.color,
                    ),
                  ),
                  onPressed: _submitForm,
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}