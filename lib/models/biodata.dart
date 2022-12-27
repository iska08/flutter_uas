class Biodata {
  int? id;
  String? name;
  String? nim;
  String? alamat;
  String? jenisKelamin;
  String? date;

  Biodata({
    this.id,
    this.name,
    this.nim,
    this.alamat,
    this.jenisKelamin,
    this.date,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['nim'] = nim;
    map['alamat'] = alamat;
    map['jenisKelamin'] = jenisKelamin;
    map['date'] = date;

    return map;
  }

  Biodata.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    nim = map['nim'];
    alamat = map['alamat'];
    jenisKelamin = map['jenisKelamin'];
    date = map['date'];
  }
}
