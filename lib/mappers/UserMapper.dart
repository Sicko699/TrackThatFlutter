import 'package:track_that_flutter/mappers/mappers.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/network/dto/UserDto.dart';

class Usermapper implements DTOMapper<UserDTO, UserModel> {
  @override
  UserModel fromDTO(UserDTO dto) {
    return UserModel(
      id: dto.id,
      firstName: dto.firstName,
      lastName: dto.lastName,
      dateOfBirth: dto.dateOfBirth,
      email: dto.email,
    );
  }

  @override
  UserDTO toDTO(UserModel model) {
    return UserDTO(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      dateOfBirth: model.dateOfBirth,
      email: model.email,
    );
  }
}
