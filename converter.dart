import 'dart:io';

void main() {
  
  Currencies currencies = new Currencies();
  currencies.doOperation();

}

class Currencies {
  
  static double usd = 84.77;
  static double eur = 101.03;
  static double rub = 1.1;
  static double kzt = 0.1868;
  static double cny = 12.2;

  static Map<String, double> curr = {
    'USD': usd,
    'EUR': eur,
    'RUB': rub,
    'KZT': kzt,
    'CNY': cny
  };
  
  Currencies() {
    print(
        "Exchange Rates: \nUSD - $usd \nEUR - $eur \nRUB - $rub \nKZT - $kzt \nCNY - $cny");
  }

  void doOperation() {
    CurrencyUtils.readUserInput();
    double result;
    switch (CurrencyUtils.getConvertationType()) {

      case OperationType.PURCHASE:
        result = CurrencyUtils._amount * curr[CurrencyUtils.getCurrencyType()];
        break;
      
      case OperationType.SALE:
        result = CurrencyUtils._amount / curr[CurrencyUtils.getCurrencyType()];
        break;
    }
    print (result);
  }
}

enum OperationType {
  PURCHASE, //-> "PURCHASE"
  SALE
}

class CurrencyUtils {

  static var _convertationType;
  static var _currencyType;
  static var _amount;

  static void readUserInput() {
    print('Choose Operation: \n1. Currency -> Som \n2. Som -> Currency');
    int operation = int.parse(stdin.readLineSync()!);

    if (operation == 1) {
      _convertationType = OperationType.PURCHASE;
    }
    else if (operation == 2) {
      _convertationType = OperationType.SALE;
    }
    else {
        throw new Exception("Wrong operation number: $operation" );
    }

    print("Which Currency?");
    _currencyType = stdin.readLineSync()!.toUpperCase().trim();

    if (!Currencies.curr.containsKey(_currencyType)) {
      throw new Exception("Wrong Currency type " + _currencyType);
    }

    print('Amount');
    _amount = int.parse(stdin.readLineSync()!);

    if (_amount < 0) {
      throw new Exception("Amount can not be negative");
    }
  }

  static OperationType getConvertationType() {
    return _convertationType;
  }

  static String getCurrencyType() {
    return _currencyType;
  }

  static int getAmount() {
    return _amount;
  }
}
