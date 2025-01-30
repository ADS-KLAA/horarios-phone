class Aula {
  final String id;
  final String curso;
  final String uc;
  final String turma;
  final int inscritos;
  final List<dynamic> confirmados;
  final List<dynamic> presencas;
  final String diaSemana;
  final String inicio;
  final String fim;
  final String dia;
  final dynamic sala;

  Aula({
    required this.id,
    required this.curso,
    required this.uc,
    required this.turma,
    required this.inscritos,
    required this.confirmados,
    required this.presencas,
    required this.diaSemana,
    required this.inicio,
    required this.fim,
    required this.dia,
    this.sala,
  });

  factory Aula.fromJson(Map<String, dynamic> json) {
    return Aula(
      id: json['id'],
      curso: json['curso'],
      uc: json['uc'],
      turma: json['turma'],
      inscritos: json['inscritos'],
      confirmados: json['confirmados'],
      presencas: json['presencas'],
      diaSemana: json['diaSemana'],
      inicio: json['inicio'],
      fim: json['fim'],
      dia: json['dia'],
      sala: json['sala'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'curso': curso,
      'uc': uc,
      'turma': turma,
      'inscritos': inscritos,
      'confirmados': confirmados,
      'presencas': presencas,
      'diaSemana': diaSemana,
      'inicio': inicio,
      'fim': fim,
      'dia': dia,
      'sala': sala,
    };
  }
}