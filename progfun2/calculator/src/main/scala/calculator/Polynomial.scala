package calculator

object Polynomial extends PolynomialInterface:
  def computeDelta(a: Signal[Double], b: Signal[Double],
      c: Signal[Double]): Signal[Double] =
    Signal {
      val bVal = b()
      bVal * bVal - 4 * a() * c()
    }

  def computeSolutions(a: Signal[Double], b: Signal[Double],
      c: Signal[Double], delta: Signal[Double]): Signal[Set[Double]] =
    Signal {
      // (-b ± √Δ) / (2a)
      val minusB = -1 * b()
      val d = delta()
      val sqrtDelta = math.sqrt(delta())
      val doubleA = 2 * a()
      if d < 0 then Set()
      else Set(
        (minusB + sqrtDelta) / doubleA,
        (minusB - sqrtDelta) / doubleA
      )
    }
