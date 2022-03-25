part of '../phone_auth_screen.dart';

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProviderAuth>();
    final providerRead = context.read<ProviderAuth>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Укажите номер телефона \nдля авторизации',
          style: TextStyle(
            fontSize: 18,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),
        DefaultTextField(
          controller: vm.phoneController,
          title: 'Введите номер телефона',
          maxLength: 10,
          onChange: (value) {
            if (value.length == 10) {
              providerRead.setPhoneFilled();
            } else {
              providerRead.setNotPhoneFilled();
            }
          },
        ),
        const SizedBox(height: 24),
        const _ButtonWidget(),
      ],
    );
  }
}
