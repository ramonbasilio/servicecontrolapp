class Orcamento {
  String cliente;
  String peca;
  double preco;

  Orcamento(this.cliente, this.peca, this.preco);
}

class OrcamentoMoc {
  final Orcamento _meuOrcamento =
      Orcamento('Ramon Basilio', 'Ventilador', 22.5);
  Orcamento get meuOrcamento => _meuOrcamento;
}

