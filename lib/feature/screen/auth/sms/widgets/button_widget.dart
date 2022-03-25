part of '../sms_screen.dart';

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProviderAuth>();
    return BlocProvider.value(
      value: AuthBloc(
        repo: RepositoryProvider.of<AuthRepo>(context),
        storage: RepositoryProvider.of<RepoSharedPrefs>(context),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Произошла ошибка, повторите'),
              ),
            );
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (state is! AuthLoading && vm.isSmsFilled.value) {
                  print('TOKEEEEEN ${context.read<ProviderAuth>().token}');
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthSendSmsEvent(
                        token: context.read<ProviderAuth>().token,
                        sms: vm.smsController.text,
                        phoneNumber: context
                            .read<ProviderAuth>()
                            .phoneController
                            .text
                            .trim()),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  vm.isSmsFilled.value
                      ? Colors.blue
                      : Colors.blue.withOpacity(0.5),
                ),
              ),
              child: state is AuthLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Отправить смс-код'.toUpperCase(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
