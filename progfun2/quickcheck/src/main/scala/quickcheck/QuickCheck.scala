package quickcheck

import org.scalacheck.*
import Arbitrary.*
import Gen.*
import Prop.forAll

abstract class QuickCheckHeap extends Properties("Heap") with IntHeap:
  lazy val genHeap: Gen[H] = for {
    a <- arbitrary[Int]
    h <- oneOf(Gen.const(empty), genHeap)
  } yield insert(a, h)

  given Arbitrary[H] = Arbitrary(genHeap)

  property("gen1") = forAll { (h: H) =>
    val m = if isEmpty(h) then 0 else findMin(h)
    findMin(insert(m, h)) == m
  }

  property("min1") = forAll { (a: Int) =>
    val h = insert(a, empty)
    findMin(h) == a
  }

  // If you insert an element into an empty heap, then delete the minimum,
  // the resulting heap should be empty.
  property("insDelEmpty") = forAll { (a: Int) =>
    val h1 = insert(a, empty)
    val h2 = deleteMin(h1)
    h2 == empty
  }

// If you insert any two elements into an empty heap, finding the
  // minimum of the resulting heap should get the smallest of the two elements back.
  property("min2") = forAll { (a: Int, b: Int) =>
    val h = insert(b, insert(a, empty))
    findMin(h) == Math.min(a, b)
  }

  // Given any heap, you should get a sorted sequence of elements
  // when continually finding and deleting minima. (Hint: recursion
  // and helper functions are your friends.)
  property("remMin") = forAll { (h: H) =>
    def delMin(ts: H, acc: List[Int]): List[Int] = {
      if (isEmpty(ts)) acc
      else findMin(ts) :: delMin(deleteMin(ts), acc)
    }
    val xs = delMin(h, Nil)
    xs == xs.sorted
  }

  // Finding a minimum of the melding of any two heaps should return a minimum of
  // one or the other.
  property("remMin") = forAll { (h1: H, h2: H) =>
    val h3 = meld(h1, h2)
    val min1 = findMin(h1)
    val min2 = findMin(h2)
    val min3 = findMin(h3)
    (min3 == min1) || (min3 == min2)
  }

  // If we transfer a min element between two heaps, the
  // result of melding the heaps is the same as the result of melding the
  // original heaps
  property("meld") = forAll { (h1: H, h2: H) =>
    def heapEqual(h1: H, h2: H): Boolean =
      if (isEmpty(h1) && isEmpty(h2)) true
      else {
        val m1 = findMin(h1)
        val m2 = findMin(h2)
        m1 == m2 && heapEqual(deleteMin(h1), deleteMin(h2))
      }

    heapEqual(meld(h1, h2),
      meld(deleteMin(h1), insert(findMin(h1), h2)))
  }