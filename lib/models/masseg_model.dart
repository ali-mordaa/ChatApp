import 'package:chat_app/constants.dart';

class MassegModel {
  final String masseg;
  final String id;
  const MassegModel(this.masseg, this.id);
  factory MassegModel.fromJosn(josnData) {
    return MassegModel(josnData[kMasseg], josnData["id"]);
  }
}
