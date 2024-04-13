//backend of user class
import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable{
  //final String id;
  final String email;
  final String password;
  final String name;
  // final String birthday;
  // final String height;
  // final String weight;  

  const MyUserEntity({
    //required this.id,
		required this.email,
    required this.password,
		required this.name,
    // required this.birthday,
    // required this.height,
    // required this.weight,    
  });

  //map out parameters 
  Map<String, Object?> toDocument() {
    return {
     // 'id': id,
			'email': email,
      'password': password,
      'name': name,
      // 'birthday': birthday,
      // 'height': height,
      // 'weight': weight,      
    };
  }

	static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      //id: doc['id'] as String,
			email: doc['email'] as String,
      password: doc['password'] as String,
      name: doc['name'] as String,
      // birthday: doc['birthday'] as String,
      // height: doc['height'] as String,
      // weight: doc['weight'] as String,      
    );
  }

  @override 
  List<Object?> get props => [email, password, name]; //id , , birthday, height, weight

  @override
  String toString() {
    return 'UserEntity: { email: $email, password: $password, name: $name}'; //id: $id , birthday: $birthday, height: $height, weight: $weight
  }
}