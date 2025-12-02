package example


// In this example, the AtomicIntegers are used to avoid the concurrency troubles. 
// It has built-in methods for decrementing and incrementing the values.

object ConcurrencyTroublesFixed_1 {
  private val value1 = new java.util.concurrent.atomic.AtomicInteger(1000)
  private val value2 = new java.util.concurrent.atomic.AtomicInteger(0)
  private val sum = new java.util.concurrent.atomic.AtomicInteger(0)


  def moveOneUnit(): Unit = {
    value1.getAndDecrement() // value1 -= 1
    value2.getAndIncrement() // value2 += 1
    if(value1.get() == 0) {
      value1.set(1000)
      value2.set(0)
    }
  }

  def updateSum(): Unit = {
    sum.set(value1.get() + value2.get()) // sum = value1 + value2
  }
  
  def execute(): Unit = {
    while(true) {
      moveOneUnit()
      updateSum()
      Thread.sleep(50)
    }
  }

  def main(args: Array[String]): Unit = {
    for (i <- 1 to 2) {
      val thread = new Thread {
        override def run = execute()
      }
      thread.start()
    }
    
    while(true) {
      updateSum()
      println(sum.get() + " [" + value1.get() + " " + value2.get() + "]")
      Thread.sleep(100)
    }
  }

}