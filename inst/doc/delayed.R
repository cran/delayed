## ---- echo=FALSE, results='hide'----------------------------------------------
library(delayed)

## ----delay_expr, echo=TRUE, results='markup'----------------------------------
# delay a simple expression
delayed_object <- delayed(3 + 4)
print(delayed_object)

# compute its result
delayed_object$compute()

## ----delay_fun, echo=TRUE, results='markup'-----------------------------------
# delay a function
x2 <- function(x) {x * x}
delayed_x2 <- delayed_fun(x2)

# calling it returns a delayed call
delayed_object <- delayed_x2(4)
print(delayed_object)

# again, we can compute its result
delayed_object$compute()

## ----delay_chain, echo=TRUE, results='markup'---------------------------------
# delay a simple expression
delayed_object_7 <- delayed(3 + 4)

# and another
delayed_object_3 <- delayed(1 + 2)

# delay a function for addition
adder <- function(x, y){x + y}
delayed_adder <- delayed_fun(adder)

# but now, use one delayed as input to another
chained_delayed_10 <- delayed_adder(delayed_object_7, delayed_object_3)

# We can still compute its result.
chained_delayed_10$compute()

## ---- fig.show='hold'---------------------------------------------------------
plot(chained_delayed_10)

## -----------------------------------------------------------------------------
library(future)
plan(multicore, workers = 2)

# re-define the delayed object from above
delayed_object_7 <- delayed(3 + 4)
delayed_object_3 <- delayed(1 + 2)
chained_delayed_10 <- delayed_adder(delayed_object_7, delayed_object_3)

# compute it using the future plan (two multicore workers), verbose mode lets
# us see the computation order
chained_delayed_10$compute(nworkers = 2, verbose = TRUE)

