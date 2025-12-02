import collection.mutable.Map

class Bank(val allowedAttempts: Integer = 3) {

    private val accountsRegistry : Map[String,Account] = Map()

    val transactionsPool: TransactionPool = new TransactionPool()
    val completedTransactions: TransactionPool = new TransactionPool()


    def processing : Boolean = !transactionsPool.isEmpty


    // Adds a new transaction for the transfer to the transaction pool
    def transfer(from: String, to: String, amount: Double) = {
        this.synchronized {
            val transaction = new Transaction(from, to, amount)
            transactionsPool.add(transaction)
        }
    }


    // Process the transactions in the transaction pool
    // The implementation needs to be completed and possibly fixed
    def processTransactions: Unit = {

        val workers : List[Thread] = 
            transactionsPool
            .iterator
            .filter(_.getStatus() == TransactionStatus.PENDING)
            .map(processSingleTransaction)
            .toList


        workers.map( element => element.start() )
        workers.map( element => element.join() )


        val succeeded: List[Transaction] = 
            transactionsPool
            .iterator
            .filter(_.getStatus() == TransactionStatus.SUCCESS)
            .toList

        val failed: List[Transaction] = 
            transactionsPool
            .iterator
            .filter(_.getStatus() == TransactionStatus.FAILED)
            .toList


        // Remove successful transactions from the pool and add them to completed transactions
        succeeded.foreach { transaction =>
            transactionsPool.remove(transaction)
            completedTransactions.add(transaction)
        }

        
        // Handle failed transactions
        failed.foreach { t =>
            if (t.getRemainingRetries() == 0) {
                transactionsPool.remove(t)
                completedTransactions.add(t)
                t.markAsFailed()
            } else {
                // Retry failed transactions by marking them as pending
                t.markAsPending()
            }
        }

        if(!transactionsPool.isEmpty) {
            processTransactions
        }
    }

    // The function creates a new thread ready to process
    // the transaction, and returns it as a return value
    private def processSingleTransaction(t: Transaction) = {

        new Thread {
            val fromAccount = getAccount(t.from)
            val toAccount = getAccount(t.to)

            (fromAccount, toAccount) match {
                
                case (Some(from), Some(to)) =>

                    // Attempt the transaction if the accounts exist and the amount is valid
                    if ((from.balance >= t.amount) && (t.amount > 0)) { 
                        // Update the balances of the accounts
                        val updatedFrom = from.withdraw(t.amount).getOrElse(from)
                        val updatedTo = to.deposit(t.amount).getOrElse(to)

                        // Update the accounts in the registry
                        accountsRegistry.update(t.from, updatedFrom)
                        accountsRegistry.update(t.to, updatedTo)

                        // Mark the transaction as successful
                        t.markAsSuccessful()
                    } else {
                        // Insufficient funds, decrement retry and update status
                        t.decrementRetries()
                        if (t.getRemainingRetries() == 0) t.markAsFailed() else t.markAsPending()
                    }
                case _ => 
                    // If either account doesn't exist, mark the transaction as failed
                    t.markAsFailed()
            }
        }
    }


    // Creates a new account and returns its code to the user.
    // The account is stored in the local registry of bank accounts.
    def createAccount(initialBalance: Double) : String = {
        val code = java.util.UUID.randomUUID.toString
        val account = new Account(code, initialBalance)
        accountsRegistry += (code -> account)
        code
    }


    // Return information about a certain account based on its code.
    // Remember to handle the case in which the account does not exist
    def getAccount(code: String): Option[Account] = {
        accountsRegistry.get(code)
    }
}
