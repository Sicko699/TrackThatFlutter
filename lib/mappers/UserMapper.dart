
import 'package:track_that_flutter/mappers/mappers.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/network/dto/UserDto.dart';

class Usermapper implements DTOMapper<UserDTO, User>{
  @override
  User fromDTO(UserDTO dto) {
    return User(
      id: dto.id,
      name: dto.name,
      email: dto.email,
    );
  }

  @override
  UserDTO toDTO(User model) {
    return UserDTO(
      id: model.id,
      name: model.name,
      email: model.email,
    );
  }

}