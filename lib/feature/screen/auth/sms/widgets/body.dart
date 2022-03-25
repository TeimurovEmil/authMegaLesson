part of '../sms_screen.dart';

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final vm = context.watch<ProviderAuth>();
    // final providerRead = context.read<ProviderAuth>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Укажите код \nиз смс-сообщения',
          style: TextStyle(
            fontSize: 18,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),
        DefaultTextField(
          controller: context.watch<ProviderAuth>().smsController,
          title: 'Введите смс-код',
          maxLength: 4,
          onChange: (value) {
            if (value.length == 4) {
              context.read<ProviderAuth>().setSmsFilled();
            } else {
              context.read<ProviderAuth>().setSmsNotFilled();
            }
          },
        ),
        const SizedBox(height: 24),
        const _ButtonWidget(),
      ],
    );
  }
}
