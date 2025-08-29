import 'package:crypto_app/model/wallet_model.dart';
import 'package:crypto_app/services/nobitex_service.dart';
import 'package:crypto_app/view/wallet/logic/wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCubit extends Cubit<WalletState> {
  final NobitexService nobitexService;

  WalletCubit(this.nobitexService) : super(const WalletState());

  Future<void> fetchWallets(String token) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final wallets = await nobitexService.getWallets(token);
      emit(state.copyWith(isLoading: false, wallets: wallets));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
