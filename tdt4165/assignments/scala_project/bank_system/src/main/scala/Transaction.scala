object TransactionStatus extends Enumeration {
  val SUCCESS, PENDING, FAILED = Value
}

class TransactionPool {

    // Create a queue to hold the transactions
    private val transaction_queue = new scala.collection.mutable.Queue[Transaction]

    // Remove and the transaction from the pool
    def remove(t: Transaction): Boolean = {
        if (transaction_queue.nonEmpty) {
            transaction_queue.dequeue()
            true
        } else {
            false
        }
    }

    // Return whether the queue is empty
    def isEmpty: Boolean = {
        transaction_queue.isEmpty
    }

    // Return the size of the pool
    def size: Integer = {
        transaction_queue.size
    }

    // Add new element to the back of the queue
    def add(t: Transaction): Boolean = {
        transaction_queue.enqueue(t)
        true
    }

    // Return an iterator to allow you to iterate over the queue
    def iterator: Iterator[Transaction] = {
        transaction_queue.iterator
    }

}

class Transaction(val from: String,
                  val to: String,
                  val amount: Double,
                  initialRetries: Int = 3) {

  private var status: TransactionStatus.Value = TransactionStatus.PENDING
  private var remainingRetries = initialRetries // mutable variable to track retries

  def getStatus(): TransactionStatus.Value = status
  def getRemainingRetries(): Int = remainingRetries

  // Implement methods that change the status of the transaction
  def markAsFailed(): TransactionStatus.Value = {
    status = TransactionStatus.FAILED
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

  // Decrement retries and return the updated value
  def decrementRetries(): Unit = {
    if (remainingRetries > 0) {
      remainingRetries -= 1
    }
  }
}