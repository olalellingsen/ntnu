
class Account(val code : String, val balance: Double) {

    // Implement functions. Account should be immutable.
    // Change return type to the appropriate one
    
    def withdraw(amount: Double) : Either[String, Account] = {
        if (amount < 0) {
            Left("Invalid amount")
        } else if (amount > balance) {
            Left("Balance is not sufficient")
        } else {
            Right(new Account(code, balance - amount))
        }
    }

    def deposit (amount: Double) : Either[String, Account] = {
        if (amount < 0) {
            Left("Invalid amount")
        } else {
            Right(new Account(code, balance + amount))
        }
    }
}
