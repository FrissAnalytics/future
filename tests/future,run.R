source("incl/start.R")
library("listenv")

message("*** future() - argument 'run' ...")

for (strategy in supportedStrategies()) {
  message("Type of future: ", strategy)
  plan(strategy)

  ## Create future, but don't launch it.
  f <- future({ 42L }, run=FALSE)
  print(f)
  printf("State: %s\n", f$state)
  stopifnot(f$state == "created")
  f <- run(f)
  print(f)
  printf("State: %s\n", f$state)
  stopifnot(f$state != "created")
  v <- value(f)
  print(v)
  stopifnot(v == 42L)

  ## Create future and run
  f <- future({ 42L }, run=TRUE)
  print(f)
  printf("State: %s\n", f$state)
  stopifnot(f$state != "created")
  v <- value(f)
  print(v)
  stopifnot(v == 42L)

  ## Invalid tweak
  res <- tryCatch(tweak(strategy, run=FALSE), error=identity)
  print(res)
  stopifnot(inherits(res, "error"))
} # for (strategy ...)

message("*** future() - argument 'run' ... DONE")

source("incl/end.R")
