import 'package:crypto_app/services/nobitex_service.dart';
import 'package:crypto_app/view/wallet/logic/wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCubit extends Cubit<WalletState> {
  final NobitexService nobitexService;
  final String token;

  WalletCubit({
    required this.nobitexService,
    required this.token,
  }) : super(WalletState());

  Future<void> fetchWallets() async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await nobitexService.getWallets(token);
      final wallets = (response['wallets'] as List).map((e) => Wallet.fromJson(e)).toList();
      emit(state.copyWith(isLoading: false, wallets: wallets));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
