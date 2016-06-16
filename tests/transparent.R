library("future")
library("listenv")

ovars <- ls()
oopts <- options(warn=1L, mc.cores=2L, future.debug=TRUE)

message("*** transparent() ...")

## No global variables
f <- try(transparent({
  42L
}), silent=FALSE)
print(f)
stopifnot(inherits(f, "EagerFuture"))

print(resolved(f))
y <- value(f)
print(y)
stopifnot(y == 42L)


plan(transparent)
## No global variables
f <- try(future({
  42L
}), silent=FALSE)
print(f)
stopifnot(inherits(f, "EagerFuture"))

print(resolved(f))
y <- value(f)
print(y)
stopifnot(y == 42L)


## A global variable
a <- 0
f <- try(future({
  b <- 3
  c <- 2
  a * b * c
}))
print(f)

message("*** transparent() ... DONE")


## Cleanup
plan(eager)
options(oopts)
rm(list=setdiff(ls(), ovars))