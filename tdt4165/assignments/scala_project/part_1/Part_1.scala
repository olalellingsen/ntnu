import scala.collection.mutable.ArrayBuffer

object Part_1 {
  def main(args: Array[String]): Unit = {


    //_________________Task 1_____________________


    // a) Create a list of integers from 0 to 50
    val mutableList = ArrayBuffer[Int]()

    for (i <- 1 to 50) {
      mutableList += i
    }

    println(mutableList)



    // b) Create a function that sums the integers in the array
    def sumArray(array: Array[Int]): Int = {
        var sum = 0
        for (i <- array) {
            sum += i
        }
        sum
    }

    val array = Array(1, 2, 3, 4, 5)
    println(sumArray(array)) // 15


    // c) Create a recursive function that sums the integers in the array
    def sumArray_recursive(array: Array[Int], index: Int = 0): Int = {
        if (index == array.length) {
            0
        } else {
            array(index) + sumArray_recursive(array, index + 1)
        }
    }

    println(sumArray_recursive(array)) // 15


    // d) Create a function to compute the nth Fibonacci number using recursion without using memoization
    
    // 0-indexed Fibonacci
    def fibonacci(n: BigInt): BigInt = {
        if (n <= 1) // base case
            n
        else 
            fibonacci(n - 1) + fibonacci(n - 2) // recursive step
    }

    println(fibonacci(5)) // 5
    println(fibonacci(10)) // 55 

    // Int is a 32-bit two’s complement integer, which has a maximum value of 2^31 - 1. 
    // BigInt can be arbitrarily large, and it is only limited by the amount of memory available.
    // Int is faster due to its fixed size, while BigInt is slower due to its dynamic size.






    //_________________Task 2_____________________

    // a) 
    // Task 1 from Assigmnent 3)
    def quadraticEquation(a: Double, b: Double, c: Double): (Boolean, Option[Double], Option[Double]) = {
        val disc: Double = b * b - (4 * a * c)
        
        if (disc >= 0.0) {
            // Real solutions exist
            val x1: Double = (-b + Math.sqrt(disc)) / (2 * a)
            val x2: Double = (-b - Math.sqrt(disc)) / (2 * a)
            println("X1: " + x1 + ", X2: " + x2)
            (true, Some(x1), Some(x2))
        } else {
            // No real solutions
            println("No real solutions")
            (false, None, None) 
        }
    }


    quadraticEquation(1, 5, 6) // X1: -2.0, X2: -3.0
    quadraticEquation(2, 1, 2) // false


    // Task 4 from Assignment 3)
    def quadratic(a: Double, b: Double, c: Double) = {
        (x: Double) => a * x * x + b * x + c // returns a function
    }

    val f = quadratic(3, 2, 1)
    println(f(2)) // 17.0



    // b)
    /* 
    In Oz, variables are immutable by default and cannot be reassigned, in Scala the programmer 
    can choose whether to use val for immutable variables or var for mutable variables. 
    Val is preffered in Scala, as it is more type-safe and functional programming oriented. 
    The values in Oz is bound within the procedure (declarative programming), while the function 
    in Scala returns values explicitly (functional programming).
    For values that are optional or may not exist, Scala uses Option and Oz uses nil. 
    Programming in Scala is more type-safe than in Oz, which makes it easier to catch errors and read the code.
     */
    





    //_________________Task 3_____________________

    // a)
    def thread_func(func: () => Unit): Thread = {
        new Thread(new Runnable {
            def run(): Unit = {
                func()
            }
        })
    }


    // b)

    /*
    See the code in ConcurrencyTroubles.scala
    
    - The code is supposed to sum two values, 'value1' and 'value2', and update the sum. 
    The sum is always supposed to be 1000, and when 'value1' reaches 0, it is reset to 1000.

    - No, it is not working as expected. After running the code for a while, the sum is not longer 1000 and we get negative values for 'value1'. 
    This does not make sense based on how the moveOneUnit function is implemented.
    
    - This is happening because the main method is creating two threads that both call the execute method and they are accessing the shared variables 'value1', 'value2' and 'sum' concurrently. 
    Multiple threads might read the same value at the same time, modify it, and then write back outdated values. This leads to inconsistent results.

    - Variables in Oz are immutable by default, which means that they cannot be changed after they are assigned/bonded. 
    An error will accur if you try to reassign a value to a variable, and thus the problem of multiple threads accessing/updating the same variables will be avoided.
    Concurrency in Oz is declarative, and even if multiple threads are running the operations on shared variables will occur when the variables are ready to be accessed.

    - In a real world e-commerce application, this problem could lead to serious issues in manegement of the inventory. 
    For instance, if several users are trying to buy the last item in stock simultaneously, and each request is processed by a separate thread, 
    the system can allow several uses to buy the same item. This can lead to wrong/negative inventory count and a lot of logistical issues.
    */


    // c) 

    /* 
    See the code in the following files:
        - ConcurrencyTroubles.scala
        - ConcurrencyTroublesFixed_1.scala
        - ConcurrencyTroublesFixed_2.scala
    */


  }
}