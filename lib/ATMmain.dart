import '../Account.dart';
import 'dart:io';
import 'dart:core';

typedef int transaction(int a, int b);

int withdraw_operation(int a, int b) => b - a;
int deposit_operation(int a, int b) => b + a;

 int withdraw(int a, int b){
  if (a<=b){
    b = withdraw_operation(a, b);
    print("Withdraw Successful\n");
  }
  else{
    print("Insufficient Balance\n");
  }
  return b;
}

int deposit(int a, int b){
  b = deposit_operation(a, b);
  print("Deposit Successful\n");
  return b;
}


void main() async {
  Account acc1 = Account(1, 1234);
  Account acc2 = Account(2, 1234);
  List <Account> accounts = <Account>[];
  accounts.add(acc1);
  accounts.add(acc2);

  var path = 'bin/account1.txt';

  bool a = true, b =true;
  div();
  print("|     Automated Teller Machine      |");
  div();
  print("|     Sample ATM CARD               |");
  print("|     Card Number: 1                |");
  print("|     Card PIN: 1234                |");
  div();
  while(a){
    print("Enter Card Number (Enter 0 to EXIT): ");
    int? inputCardNumber = int.parse(stdin.readLineSync()!);
    if (inputCardNumber == 0){
      b = false;
      break;
    }
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[i].acctNum == inputCardNumber) {
        for (var j = 4; j >= 0; j--) {
          print("Enter PIN: ");
          int? inputPin = int.parse(stdin.readLineSync()!);
          if (accounts[i].pin == inputPin) {
            print("LOG IN SUCCESSFUL");
            a = false;
            break;
          }
          else {
            if (j > 0) {
              print('Wrong PIN, Number of Tries ($j), Enter Again');
            } else {
              print('Wrong PIN, Enter Card');
            }
          }
        }
      }
    }
  }
  while(b){
    div();
    print("TYPE 1 to Withdraw");
    print("TYPE 2 to Deposit");
    print("TYPE 3 to Check Balance");
    print("TYPE 4 to EXIT");
    div();
    String? input = stdin.readLineSync();
    var contents;
    switch (input) {
      case "1":
      {
        try {
          var file = File(path);
          contents = await file.readAsString();
        }
        catch (e) {
          stderr.writeln('failed to read file: \n${e}');
        }
        print("--------------Withdraw--------------");
        print("Enter Amount P: ");
        int? inputAmount = int.parse(stdin.readLineSync()!);
        int currentBalance = int.parse(contents);

        transaction t = withdraw;
        currentBalance = t(inputAmount, currentBalance);

        String writeBalance = currentBalance.toString();
        File(path).writeAsString(writeBalance);
        var file = File(path);

        contents = await file.readAsString();
        print("Current Balance: $contents");
      }
      break;

      case "2":
      {
        try {
          var file = File(path);
          contents = await file.readAsString();
        }
        catch (e) {
          stderr.writeln('failed to read file: \n${e}');
        }
        print("--------------Deposit---------------");
        print("Enter Amount P: ");
        int? inputAmount = int.parse(stdin.readLineSync()!);
        int currentBalance = int.parse(contents);


        transaction t = deposit;
        currentBalance = t(inputAmount, currentBalance);

        String writeBalance = currentBalance.toString();
        File(path).writeAsString(writeBalance);
        var file = File(path);

        contents = await file.readAsString();
        print("Current Balance: $contents");
      }
      break;

      case "3":
      {
        print("-----------Check-Balance------------");
        try {
          var file = File(path);
          contents = await file.readAsString();
          print("Current Balance: $contents");
        }
        catch (e) {
          stderr.writeln('failed to read file: \n${e}');
        }
      }
      break;

      case "4":
        {
          print("EXIT");
          b = false;
          break;
        }

      default:
        {
          print("Invalid choice");
        }
        break;
    }
  }
}

void div()
{
  print("-------------------------------------");
}

