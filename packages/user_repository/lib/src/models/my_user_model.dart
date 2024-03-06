//user class
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';
class MyUserModel extends Equatable{

  //final String id;
  final String email;
  final String name;

  const MyUserModel({
    //required this.id,
		required this.email,
		required this.name,
  });

	/// Empty user which represents an unauthenticated user.
  static final empty = MyUserModel(
		//id: '', 
		email: '',
		name: '',
	);

  /// Modify MyUser parameters
	MyUserModel copyWith({
    //String? id,
    String? email,
    String? name,
  }) {
    return MyUserModel(
      //id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
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
      name: name,
    );
  } //send to entity to convert to Json

	static MyUserModel fromEntity(MyUserEntity entity) {
    return MyUserModel(
      //id: entity.id,
      email: entity.email,
      name: entity.name,
    );
  } //transform Json into entity


  @override 
  List<Object?> get props => [];
}