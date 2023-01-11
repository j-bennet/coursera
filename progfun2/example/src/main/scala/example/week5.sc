object frp:

  trait Signal[+T]:
    def apply(): Signal.Observed[T]

  object Signal:

    opaque type Observer = AbstractSignal[?]
    type Observed[T] = Observer ?=> T
    def caller(using o: Observer): Observer = o

    abstract class AbstractSignal[T] extends Signal[T]:
      private var currentValue: T = _
      private var observers: Set[Observer] = Set()

      protected def eval: Observed[T]

      protected def computeValue(): Unit =
        val newValue = eval(using this)
        val observeChange = observers.nonEmpty && newValue != currentValue
        currentValue = newValue
        if observeChange then
          val obs = observers
          observers = Set()
          obs.foreach(_.computeValue())

      def apply(): Observed[T] =
          observers += caller
          assert(!caller.observers.contains(this), "cyclic signal definition")
          currentValue

    end AbstractSignal

    def apply[T](expr: => Observed[T]): Signal[T] =
      new AbstractSignal[T]:
        val eval = expr
        computeValue()

    class Var[T](expr: => Observed[T]) extends AbstractSignal[T]:
      protected var eval = expr
      computeValue()

      def update(expr: => Observed[T]): Unit =
        eval = expr
        computeValue()
    end Var

    given noObserver: Observer = new AbstractSignal[Nothing]:
      override def eval = ???
      override def computeValue() = ()

  end Signal
end frp
