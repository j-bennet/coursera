package funsets

import org.scalatest.FunSuite


import org.junit.runner.RunWith
import org.scalatest.junit.JUnitRunner

/**
 * This class is a test suite for the methods in object FunSets. To run
 * the test suite, you can either:
 *  - run the "test" command in the SBT console
 *  - right-click the file in eclipse and chose "Run As" - "JUnit Test"
 */
@RunWith(classOf[JUnitRunner])
class FunSetSuite extends FunSuite {

  /**
   * Link to the scaladoc - very clear and detailed tutorial of FunSuite
   *
   * http://doc.scalatest.org/1.9.1/index.html#org.scalatest.FunSuite
   *
   * Operators
   *  - test
   *  - ignore
   *  - pending
   */

  /**
   * Tests are written using the "test" operator and the "assert" method.
   */
  // test("string take") {
  //   val message = "hello, world"
  //   assert(message.take(5) == "hello")
  // }

  /**
   * For ScalaTest tests, there exists a special equality operator "===" that
   * can be used inside "assert". If the assertion fails, the two values will
   * be printed in the error message. Otherwise, when using "==", the test
   * error message will only say "assertion failed", without showing the values.
   *
   * Try it out! Change the values so that the assertion fails, and look at the
   * error message.
   */
  // test("adding ints") {
  //   assert(1 + 2 === 3)
  // }


  import FunSets._

  test("contains is implemented") {
    assert(contains(x => true, 100))
  }

  /**
   * When writing tests, one would often like to re-use certain values for multiple
   * tests. For instance, we would like to create an Int-set and have multiple test
   * about it.
   *
   * Instead of copy-pasting the code for creating the set into every test, we can
   * store it in the test class using a val:
   *
   *   val s1 = singletonSet(1)
   *
   * However, what happens if the method "singletonSet" has a bug and crashes? Then
   * the test methods are not even executed, because creating an instance of the
   * test class fails!
   *
   * Therefore, we put the shared values into a separate trait (traits are like
   * abstract classes), and create an instance inside each test method.
   *
   */

  trait TestSets {
    val s1 = singletonSet(1)
    val s2 = singletonSet(2)
    val s3 = singletonSet(3)
    val n1 = singletonSet(-1)
    val n2 = singletonSet(-2)
    val n3 = singletonSet(-3)
  }

  /**
   * This test is currently disabled (by using "ignore") because the method
   * "singletonSet" is not yet implemented and the test would fail.
   *
   * Once you finish your implementation of "singletonSet", exchange the
   * function "ignore" by "test".
   */
  test("singletonSet(1) contains 1") {

    /**
     * We create a new instance of the "TestSets" trait, this gives us access
     * to the values "s1" to "s3".
     */
    new TestSets {
      /**
       * The string argument of "assert" is a message that is printed in case
       * the test fails. This helps identifying which assertion failed.
       */
      assert(contains(s1, 1), "Singleton")
    }
  }

  test("union contains all elements of each set") {
    new TestSets {
      val s = union(s1, s2)
      assert(contains(s, 1), "Union 1")
      assert(contains(s, 2), "Union 2")
      assert(!contains(s, 3), "Union 3")
    }
  }

  test("Intersect works") {
    val s1 = union(singletonSet(1), singletonSet(2))
    val s2 = union(singletonSet(2), singletonSet(3))
    val res = intersect(s1, s2)
    assert(contains(res, 2), "Intersect contains 2")
    assert(!contains(res, 1), "Intersect does not contain 1")
    assert(!contains(res, 3), "Intersect does not contain 3")
  }

  test("filter works") {
    new TestSets {
      val both = union(union(s1, s2), union(n1, n2))
      val sPos = filter(both, x => x > 0)
      val sNeg = filter(both, x => x < 0)
      assert(contains(sPos, 1), "Filter positive 1")
      assert(contains(sPos, 2), "Filter positive 2")
      assert(!contains(sPos, -1), "Filter positive -1")
      assert(!contains(sPos, -2), "Filter positive -2")
      assert(contains(sNeg, -1), "Filter negative -1")
      assert(contains(sNeg, -2), "Filter negative -2")
      assert(!contains(sNeg, 1), "Filter negative 1")
      assert(!contains(sNeg, 2), "Filter negative 2")
    }
  }

  test("forall > 0, forall < 0") {
    new TestSets {
      val sPos = union(s1, s2)
      val sNeg = union(n1, n2)
      assert(forall(sPos, x => x > 0), "All > 0")
      assert(forall(sNeg, x => x < 0), "All < 0")
    }
  }

  test("exists > 0, exists < 0") {
    new TestSets {
      assert(exists(s1, x => x > 0), "Exists > 0")
      assert(forall(n1, x => x < 0), "Exists < 0")
    }
  }

}
