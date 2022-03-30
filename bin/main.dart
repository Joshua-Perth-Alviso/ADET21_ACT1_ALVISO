import 'package:untitled1/untitled1.dart' as untitled1;
import "dart:io";

typedef Actions = Function(int balance, int input);
deposit(int balance, int input) => balance + input;
withdraw(int balance, int input) => balance - input;

class AccountActions{
  Actions newBalanceDeposit = deposit;
  Actions newBalanceWithdraw = withdraw;

  int depositNow(int balance, int input){
    return newBalanceDeposit(balance, input);
  }
  int withdrawNow(int balance, int input){
    return newBalanceWithdraw(balance, input);
  }
}


class Account implements AccountActions{
  var AccountFName;
  var AccountLName;
  var AccountMidInit;
  var AccountNumber;
  var PinCode;
  var Balance;

  void showAccountDetails(){
    print("Account Name: " + AccountFName + " " + AccountMidInit + ". " + AccountLName);
    print("Account Number: " + AccountNumber);
    print("Balance: $Balance");
  }

  @override
  Actions newBalanceDeposit = deposit;

  @override
  Actions newBalanceWithdraw =  withdraw;

  @override
  int depositNow(int balance, int input) {
    return newBalanceDeposit(balance, input);
  }

  @override
  int withdrawNow(int balance, int input) {
    return newBalanceWithdraw(balance, input);
  }
}


void main(List<String> arguments) {

  //Sample Account
  var a1 = Account();
  //Name
  a1.AccountFName = "Joshua Perth";
  a1.AccountMidInit = "Y";
  a1.AccountLName = "Alviso";
  //Log in Credentials
  a1.AccountNumber = "123789";
  a1.PinCode = "123456";
  a1.Balance =  15000;

  //Terminators
  bool logInFlag = false;
  bool processFlag = true;


  while(logInFlag == false){
    print("Type EXIT to exit the program\n");

    stdout.write("Account Number: ");
    String? accNum = stdin.readLineSync();

    if(accNum == "EXIT"){
      print("Thank you for using my Program!");
      break;
    }

    stdout.write("Pin code: ");
    String? pin = stdin.readLineSync();

    if(accNum == a1.AccountNumber && pin == a1.PinCode){
      print("Welcome " + a1.AccountFName);
      print("""What do you want to do today?
      [1]: Show Account Details
      [2]: Deposit
      [3]: Withdraw
      """);

      while(processFlag){
        int newBal;
        stdout.write("process: ");
        int? process = int.parse(stdin.readLineSync()!);

        switch(process){

          case 1:
            a1.showAccountDetails();
            break;
          case 2:
            print("\n||DEPOSIT||");

            stdout.write("Amount (PHP): ");
            int? inputAmount = int.parse(stdin.readLineSync()!);
            a1.Balance = a1.newBalanceDeposit(a1.Balance, inputAmount);

            newBal = a1.Balance;
            print("New Balance: $newBal");
            break;
          case 3:
            print("\n||WITHDRAW||");

            stdout.write("Amount (PHP): ");
            int? inputAmount = int.parse(stdin.readLineSync()!);

            if(inputAmount > a1.Balance){
              print("Account has insufficient Balance!");
              break;
            }else{
              a1.Balance = a1.newBalanceWithdraw(a1.Balance, inputAmount);
              newBal = a1.Balance;
              print("New Balance: $newBal");
              break;
            }
          default:
            processFlag = true;
            break;

        }

        stdout.write("\n[C]ontinue or [E]xit: ");
        String? ans = stdin.readLineSync();

        if(ans == "C" || ans == "c"){
          processFlag = true;
        }else if(ans == "E" || ans == "e"){
          processFlag = false;
        }else{
          print("Choice out of bounds");
          print("Force Exiting... \n");

          print("Thank you for using my Program");
          processFlag = false;
        }
      }

      logInFlag = true;
    }else{
      print("Wrong credentials \n");
      logInFlag = false;

    }
  }

}
