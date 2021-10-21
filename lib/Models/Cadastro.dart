class Cadastro {
  int? id;
  late String nome;
  late String endereco;
  late String telefone;

  Cadastro(this.nome,this.endereco,this.telefone);

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'nome' : nome,
      'endereco' : endereco,
      'telefone' : telefone,
    };
  }
  Cadastro.fromMap(Map<String,dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    endereco = map['endereco'];
    telefone = map['telefone'];
  }
}
