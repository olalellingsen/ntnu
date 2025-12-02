error id: file://<WORKSPACE>/bank_system/src/main/scala/Transaction.scala:[1446..1449) in Input.VirtualFile("file://<WORKSPACE>/bank_system/src/main/scala/Transaction.scala", "object TransactionStatus extends Enumeration {
  val SUCCESS, PENDING, FAILED = Value
}

class TransactionPool {

    // Create a queue to hold the transactions
    private val transaction_queue = new scala.collection.mutable.Queue[Transaction]

    // Remove and the transaction from the pool
    def remove(t: Transaction): Boolean = this.synchronized {
        if (transaction_queue.nonEmpty) {
            transaction_queue.dequeue()
            true
        } else {
            false
        }
    }

    // Return whether the queue is empty
    def isEmpty: Boolean = this.synchronized {
        transaction_queue.isEmpty
    }

    // Return the size of the pool
    def size: Integer = this.synchronized {
        transaction_queue.size
    }

    // Add new element to the back of the queue
    def add(t: Transaction): Boolean = this.synchronized {
        transaction_queue.enqueue(t)
        true
    }

    // Return an iterator to allow you to iterate over the queue
    def iterator: Iterator[Transaction] = this.synchronized {
        transaction_queue.iterator
    }

}

class Transaction(val from: String,
                  val to: String,
                  val amount: Double,
                  val retries: Int = 3) {

  private var status: TransactionStatus.Value = TransactionStatus.PENDING
  private var attempts = 0

  def getStatus() = status

  def 


  // Implement methods that change the status of the transaction
  def markAsFailed(): TransactionStatus.Value = {
    status = TransactionStatus.FAILED
    attempts += 1
    status
  }

  def markAsSuccessful(): TransactionStatus.Value = {
    status = TransactionStatus.SUCCESS
    status
  }

  def markAsPending(): TransactionStatus.Value = {
    status = TransactionStatus.PENDING
    status
  }

}
")
file://<WORKSPACE>/bank_system/src/main/scala/Transaction.scala
file://<WORKSPACE>/bank_system/src/main/scala/Transaction.scala:57: error: expected identifier; obtained def
  def markAsFailed(): TransactionStatus.Value = {
  ^
#### Short summary: 

expected identifier; obtained def