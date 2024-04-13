//user class
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';

class MyUserModel extends Equatable{

  //final String id;
  final String email;
  final String password;
  final String name;
  // final String? birthday;
  // final String? height;
  // final String? weight;  


  const MyUserModel({
    //required this.id,
		required this.email,
    required this.password,
		required this.name,
    // this.birthday,
    // this.height,
    // this.weight,
  });

	/// Empty user which represents an unauthenticated user.
  static const empty = MyUserModel(
		//id: '', 
		email: '',
    password: '',
		name: '',
    // birthday: '',
    // height: '',
    // weight: '',    
	);

  /// Modify MyUser parameters
	MyUserModel copyWith({
    //String? id,
    String? email,
    String? password,
    String? name,
    // String? birthday,
    // String? height,
    // String? weight,    
  }) {
    return MyUserModel(
      //id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      // birthday: birthday ?? this.birthday, 
      // height: height ?? this.height,
      // weight: weight ?? this.weight,      
    );
  }
  /// Determine whether the current user is empty.
  bool get isEmpty => this == MyUserModel.empty;

  // Determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUserModel.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      //id: id,
      email: email,
      password: password,
      name: name,
      // birthday: birthday, 
      // height: height,
      // weight: weight,      
    );
  } //send to entity to convert to Json

	static MyUserModel fromEntity(MyUserEntity entity) {
    return MyUserModel(
      //id: entity.id,
      email: entity.email,
      password: entity.password,
      name: entity.name,

      // birthday: entity.birthday, 
      // height: entity.height,
      // weight: entity.weight,      
    );
  } //transform Json into entity


  @override 
  List<Object?> get props => [email, password, name];
  //, birthday, height, weight
}