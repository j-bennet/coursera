import scala.annotation.tailrec

// parameters are passed by name
@tailrec
def repeatUntil(command: => Unit)(condition: => Boolean): Unit =
  command
  if !condition then repeatUntil(command)(condition)


var foo = 1

repeatUntil {
  foo += 1
  println(foo)
} (foo == 5)

/**
  * repeat {
  *   command
  * } until (condition)
  *
  * how to support this?
  * it will expand into:
  * repeat(command).until(condition)
  * so repeat result must have an .until method
  */

class Until(body: Unit):
  infix def until(cond: => Boolean): Unit =
    if !cond then
      body
      until(cond)

def repeat(body: => Unit) = Until(body)
