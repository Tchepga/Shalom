class Clients {
  String immatriculation='';
  String name='';
  String adress='';
  String model='';
  String note='';
  double montant=0;
  bool isSuspect=false;

  Clients(
      {this.immatriculation,
      this.name,
      this.adress,
      this.model,
      this.montant,
      this.note,
      this.isSuspect});

  Clients.fromJson(Map<String, dynamic> json)
      : immatriculation = json['immatriculation'],
        name = json['name'],
        adress = json['adress'],
        model = json['model'],
        note = json['note'],
        montant = json['montant'],
        isSuspect = json['isSuspect'];

  Map<String, dynamic> toJson() => {
        'immatriculation': immatriculation,
        'name': name,
        'adress': adress,
        'model': model,
        'note': note,
        'montant': montant,
        'isSuspect': isSuspect
      };
  Map<String, dynamic> toMap() {
    return {
      'immatriculation': immatriculation,
      'name': name,
      'adress': adress,
      'model': model,
      'note': note,
      'montant': montant,
      'isSuspect': isSuspect
    };
  }
}
