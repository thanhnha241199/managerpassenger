import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managepassengercar/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:managepassengercar/blocs/chat/bloc/chat_bloc.dart';
import 'package:managepassengercar/blocs/employee/bloc/employee_bloc.dart';
import 'package:managepassengercar/blocs/employee/view/employee.dart';
import 'package:managepassengercar/blocs/notification/bloc/notification_bloc.dart';
import 'package:managepassengercar/blocs/payment/bloc/payment_bloc.dart';
import 'package:managepassengercar/blocs/rental/bloc/rental_bloc.dart';
import 'package:managepassengercar/blocs/savelocation/blocs/location_bloc.dart';
import 'package:managepassengercar/blocs/splash/bloc/splash_screen_bloc.dart';
import 'package:managepassengercar/blocs/splash/splash_page.dart';
import 'package:managepassengercar/blocs/ticket/blocs/ticket_bloc.dart';
import 'package:managepassengercar/blocs/userprofile/blocs/profile_bloc.dart';
import 'package:managepassengercar/repository/address_repository.dart';
import 'package:managepassengercar/repository/chat_repository.dart';
import 'package:managepassengercar/repository/employee_repository.dart';
import 'package:managepassengercar/repository/notification_repository.dart';
import 'package:managepassengercar/repository/payment_repository.dart';
import 'package:managepassengercar/repository/profile_repository.dart';
import 'package:managepassengercar/repository/rental_repository.dart';
import 'package:managepassengercar/repository/ticket_repository.dart';
import 'package:managepassengercar/repository/user_repository.dart';
import 'package:managepassengercar/src/views/home/bottombar.dart';
import 'package:managepassengercar/src/views/introduction/introdure_page.dart';
import 'package:managepassengercar/src/views/widget/loading.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final ThemeData themeData;

  MyApp({Key key, @required this.userRepository, this.themeData})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                SplashScreenBloc(SplashScreenInitial(), ProfileRepository())),
        BlocProvider(
            create: (context) =>
                RentalBloc(RentalInitialState(), RentalRepository())),
        BlocProvider(
            create: (context) => NotificationBloc(
                NotificationInitialState(), NotificationRepository())),
        BlocProvider(
            create: (context) =>
                EmployeeBloc(EmployeeInitialState(), EmployeeRepository())),
        BlocProvider(
            create: (context) =>
                ChatBloc(InitialChatState(), ChatRepository())),
        BlocProvider(
            create: (context) =>
                PaymentBloc(PaymentInitialState(), PaymentRepository())),
        BlocProvider(
          create: (context) =>
              TicketBloc(TicketInitialState(), TicketRepository()),
        ),
        BlocProvider(
          create: (context) =>
              ProfileBloc(InitialProfileState(), ProfileRepository()),
        ),
        BlocProvider(
          create: (context) => AddressBloc(InitialState(), AddressRepository()),
        ),
        BlocProvider<AuthenticationBloc>(create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted());
        })
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              return SplashScreenPage();
            }
            if (state is AuthenticationInitialized) {
              return IntrodurePage(userRepository: userRepository);
            }
            if (state is AuthenticationAuthenticatedUser ||
                state is AuthenticationUnauthenticated) {
              return HomePage(userRepository: userRepository);
            }
            if (state is AuthenticationAuthenticatedEmployee) {
              return Employee(userRepository: userRepository);
            }
            return Loading();
          },
        ),
      ),
    );
  }
}
