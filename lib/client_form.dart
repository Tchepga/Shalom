import 'package:beautiful_list/model/clients.dart';
import 'package:flutter/material.dart';


class FormClient extends StatelessWidget {
  final Clients client;
  FormClient({Key key, this.client}) : super(key: key);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final immatriculation = TextField(
    decoration:
        InputDecoration( hintText: 'Immatriculation'),
  );
  final adressClient = TextField(
    decoration:
        InputDecoration( hintText: 'Adresse'),
  );
  final nameClient = TextField(
    decoration:
        InputDecoration( hintText: 'nom'),
  );
 
  final noteContent = TextField(
    decoration:
        InputDecoration(hintText: 'Remarque'),
  );

  @override
  Widget build(BuildContext context) {
    final submitBtn = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          onPressed: () {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            if (_formKey.currentState.validate()) {
              // If the form is valid, we want to show a Snackbar
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
            }
          },
          child: Text('Enregistrer'),
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Ajout d'une nouvelle grivelerie"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                const SizedBox(height: 24.0),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: 'Write immatriculation number',
                    labelText: 'Immatriculation *',
                  ),
                  onSaved: (String value) { client.immatriculation = value; },
                  //validator: _validateName,
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.phone),
                    hintText: 'enter the complet name',
                    labelText: 'Nom *',
                    prefixText: '+1',
                  ),
                  //keyboardType: TextInputType.phone,
                  onSaved: (String value) { client.name = value; },
                  //validator: _validatePhoneNumber,
                  // TextInputFormatters are applied in sequence.
                 /* inputFormatters: <TextInputFormatter> [
                    WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    _phoneNumberFormatter,
                  ],*/
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.email),
                    hintText: 'Your  address',
                    labelText: 'Adresse',
                  ),
                  //keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) { client.adress = value; },
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'les remarques importantes',
                    //helperText: 'Keep it short, this is just a demo.',
                    labelText: 'notes importantes',
                  ),
                  maxLines: 3,
                ),
               
                const SizedBox(height: 24.0),
                Center(
                  child: RaisedButton(
                    child: const Text('Enregister'),
                    //onPressed: _handleSubmitted,
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  '* indicates required field',
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(height: 24.0),
            ],
          ),
        ));
  }
}
