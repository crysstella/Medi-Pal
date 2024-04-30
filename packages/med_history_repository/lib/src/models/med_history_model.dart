//user class
import 'package:equatable/equatable.dart';

class MedHistoryModel extends Equatable{

  //final String id;
  final List<String> allergy;
  final List<String> disease;
  final List<String> diet;
  // final String? birthday;
  // final String? height;
  // final String? weight;  


  const MedHistoryModel({
    //required this.id,
		required this.allergy,
    required this.disease,
		required this.diet,
    // this.birthday,
    // this.height,
    // this.weight,
  });

	/// Empty user which represents an unauthenticated user.
  static const empty = MedHistoryModel(
		//id: '', 
		allergy: [],
    disease: [],
		diet: [],
    // birthday: '',
    // height: '',
    // weight: '',    
	);

  /// Modify MyUser parameters
	MedHistoryModel copyWith({
    //String? id,
    List<String>? allergy,
    List<String>? disease,
    List<String>? diet,
    // String? birthday,
    // String? height,
    // String? weight,    
  }) {
    return MedHistoryModel(
      //id: id ?? this.id,
      allergy: allergy ?? this.allergy,
      disease: disease ?? this.disease,
      diet: diet ?? this.diet,
      // birthday: birthday ?? this.birthday, 
      // height: height ?? this.height,
      // weight: weight ?? this.weight,      
    );
  }
  /// Determine whether the current user is empty.
  bool get isEmpty => this == MedHistoryModel.empty;

  // Determine whether the current user is not empty.
  bool get isNotEmpty => this != MedHistoryModel.empty;


  @override 
  List<Object?> get props => [allergy, disease, diet];
  //, birthday, height, weight
}

  // MedHistoryEntity toEntity() {
  //   return MedHistoryEntity(
  //     //id: id,
  //     allergy: allergy,
  //     disease: disease,
  //     diet: diet,
  //     // birthday: birthday, 
  //     // height: height,
  //     // weight: weight,      
  //   );
  // } //send to entity to convert to Json

	// static MedHistoryModel fromEntity(MedHistoryEntity entity) {
  //   return MedHistoryModel(
  //     //id: entity.id,
  //     allergy: entity.allergy,
  //     disease: entity.disease,
  //     diet: entity.diet,

  //     // birthday: entity.birthday, 
  //     // height: entity.height,
  //     // weight: entity.weight,      
  //   );
  // } //transform Json into entity