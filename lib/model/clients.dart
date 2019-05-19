class Clients {
  String immatriculation='';
  String name='';
  String adress='';
  String model='';
  String note='';
  double montant=0;
  double othermontant1 =0;
  double othermontant2 = 0;
  double othermontant3 = 0;
  bool isSuspect=false;
  bool status=false;

  Clients(
      {this.immatriculation,
      this.name,
      this.adress,
      this.model,
      this.montant,
      othermontant1,
      othermontant2,
      othermontant3,
      this.note,
      this.isSuspect,
      this.status});

  Clients.fromJson(Map<String, dynamic> json)
      : immatriculation = json['immatriculation'],
        name = json['name'],
        adress = json['adress'],
        model = json['model'],
        note = json['note'],
        montant = json['montant'],
        othermontant1 = json['othermontant1'],
        othermontant2 = json['othermontant2'],
        othermontant3 = json['othermontant3'],
        isSuspect = json['isSuspect'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'immatriculation': immatriculation,
        'name': name,
        'adress': adress,
        'model': model,
        'note': note,
        'montant': montant,
        'othermontant1': othermontant1,
        'othermontant2': othermontant2,
        'othermontant3': othermontant3,
        'isSuspect': isSuspect,
        'status' : status
      };
  Map<String, dynamic> toMap() {
    return {
      'immatriculation': immatriculation,
      'name': name,
      'adress': adress,
      'model': model,
      'note': note,
      'montant': montant,
      'othermontant1': othermontant1,
      'othermontant2': othermontant2,
      'othermontant3': othermontant3,
      'isSuspect': isSuspect,
      'status' : status
    };
  }
}
