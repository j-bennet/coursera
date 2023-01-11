case class Rational(numer: Int, denom: Int)

trait Ordering[A]:
  def compare(x: A, y: A): Int

  extension(x: A)
    def < (y: A): Boolean = compare(x, y) < 0
    def <= (y: A): Boolean = compare(x, y) <= 0
    def > (y: A): Boolean = compare(x, y) > 0
    def >= (y: A): Boolean = compare(x, y) >= 0

given listOrdering[A](using ord: Ordering[A]): Ordering[List[A]] with
  def compare(xs: List[A], ys: List[A]): Int = (xs, ys) match {
    case (Nil, Nil) => 0
    case (Nil, _) => -1
    case (_, Nil) => 1
    case(x::xs1, y::ys1) =>
      val c = ord.compare(x, y)
      if c != 0 then c
      else compare(xs1, ys1)
  }

given pairOrdering[A, B](using orda: Ordering[A], ordb: Ordering[B]): Ordering[(A, B)] with
  def compare(x: (A, B), y: (A, B)): Int =
    val c = orda.compare(x._1, y._1)
    if c != 0 then c else ordb.compare(x._2, y._2)

given RationalOrdering: Ordering[Rational] with
  def compare(x: Rational, y: Rational): Int =
    val left = x.denom * x.numer
    val right = y.denom * y.numer
    if left < right then -1
    else if left > right then 1
    else 0

trait SemiGroup[T]:
  extension (x: T) def combine (y: T): T

trait Monoid[T] extends SemiGroup[T]:
  def unit: T

// returns Monoid[T] instance that's currently visible
object Monoid:
  def apply[T](using m: Monoid[T]): Monoid[T] = m

//def reduce[T](xs: List[T])(using m: Monoid[T]): T =
//  xs.foldLeft(m.unit)(_.combine(_))

// context bound definition, uses summon
//def reduce2[T: Monoid](xs: List[T]): T =
//  xs.foldLeft(summon[Monoid[T]].unit)(_.combine(_))

// context bound definition, uses apply from Monoid companion object,
// no need for summon
given sumMonoid: Monoid[Int] with
  extension (x: Int) def combine(y: Int): Int = x + y
  def unit: Int = 0

given prodMonoid: Monoid[Int] with
  extension (x: Int) def combine(y: Int): Int = x * y
  def unit: Int = 1

def reduce[T: Monoid](xs: List[T]): T =
  xs.foldLeft(summon[Monoid[T]].unit)(_.combine(_))

def sum(xs: List[Int]) = reduce(xs)(using sumMonoid)
def product(xs: List[Int]) = reduce(xs)(using prodMonoid)

val xs = List(1, 2, 3, 4)
sum(xs)
product(xs)
