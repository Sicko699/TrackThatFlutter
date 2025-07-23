import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/pine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:track_that_flutter/mappers/UserMapper.dart';
import 'package:track_that_flutter/model/entities/user.dart';
import 'package:track_that_flutter/network/firebase_service.dart';
import 'package:track_that_flutter/network/service/authService.dart';
import 'package:track_that_flutter/network/service/impl/authService_impl.dart';
import 'package:track_that_flutter/repositories/authRepo.dart';
import 'package:track_that_flutter/repositories/impl/authRepo_impl.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/register_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/first_cubit/login_cubit.dart';
import 'package:track_that_flutter/state_management/cubits/auth/auth_cubit.dart';

part 'blocs.dart';
part 'mappers.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
        blocs: blocs,
        mappers: _mappers,
        repositories: repositories,
        providers: _providers,
        child: child,
      );
}
