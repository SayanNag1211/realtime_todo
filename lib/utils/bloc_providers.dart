part of '../main.dart';

List<BlocProvider> blocProviders = [
  BlocProvider(create: (context) => HomeBloc()),
  // BlocProvider(create: (context) => ServicePolicyBloc()),
];
