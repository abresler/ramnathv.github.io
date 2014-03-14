#' Creates a block grid of a given data type
#' 
#' @param nrow 
#' @examples
#' grid1 = block_grid(10, 10)
#' grid1 = block_grid(10, 10, 'matrix')
#' grid1[1]  = 'red'
#' grid1
#' grid1 = block_grid(10, type = 'vector')
#' grid1[1]  = 'red'
#' grid1
block_grid = function(nrow, ncol = nrow, type = 'data.frame', fill = "#7BEA7B"){
  data_ = matrix(fill, nrow, ncol)
  blk = switch(type,
    "data.frame" = as.data.frame(data_, stringsAsFactors = F),
    "data.table" = {library(data.table); data.table(data_)},
    "matrix" = data_,
    "vector" = rep(fill, nrow)
  )
  as.block(blk)
}

block_list = function(x){
  
}

#' Display a block grid
#' 
#' The implementation here is borrowed from sna::plot.sociomatrix
display = function(block){
  gap = 0.5
  if (!is.atomic(block) && is.null(dim(block))){
    maxLen = max(sapply(block, length)) 
    data = as.data.frame(matrix('white', maxLen, length(block)))
    for (i in seq_along(block)){
      data[i] <- c(
        rep("#7BEA7B", length(block[[i]])),
        rep('white', maxLen - length(block[[i]]))
      )
    }
  } else if (length(dim(block)) < 2){
    data = matrix('white', length(block) - 1, length(block))
    data[1,] = block
  } else {
    data = block
  }
  n = dim(data)[1]; o = dim(data)[2]
  drawlines = TRUE
  cur_mar = par('mar')
  par(mar = c(0.5, 0.5, 0.5, 0.5))
  colors_ = c('#7BEA7B', 'red')
  plot(1, 1, xlim = c(0, o + 1), ylim = c(n + 1, 0), type = "n",
    axes = FALSE, xlab = "", ylab = ""
  )
  if (is.data.frame(data)){
    segments(1, 0, o, 0, col = 'darkgray')
    # points(1:n, rep(0, o), pch = 16)
    text(1:o, rep(0, o), labels = names(data), font = 2)
    segments(1:o, 0.1, 1:o, 0.5, col = 'darkgray')
    gap = 0.4
  }
  for (i in 1:n){
    for (j in 1:o) {
      rect(j - gap, i + 0.5, j + gap, i - 0.5, 
         col = data[i, j], xpd = TRUE, border = 'white'
      )
    }
  }
  rect(0.5, 0.5, o + 0.5, n + 0.5, col = NA, xpd = TRUE, border = 'white')
  par(mar = cur_mar)
}

print.block = function(x){
  display(x)
}

print_raw = function(x){
  class(x) = class(x)[-1]
  print(x)
}

as.block = function(x){
  class(x) = c('block', class(x))
  return(x)
}

#' Hook to crop png using imagemagick convert
#' 
#' 
hook_crop_png = function(before, options, envir){
  if (before){
    return()
  }
  ext = tolower(options$fig.ext)
  if (ext != "png") {
    warning("this hook only works with PNG at the moment")
    return()
  }
  if (!nzchar(Sys.which("convert"))) {
    warning("cannot find convert; please install and put it in PATH")
    return()
  }
  paths = knitr:::all_figs(options, ext)
  lapply(paths, function(x) {
    message("optimizing ", x)
    x = shQuote(x)
    cmd = paste("convert", if (is.character(options$convert)) 
      options$convert, x, x)
    if (.Platform$OS.type == "windows") 
      cmd = paste(Sys.getenv("COMSPEC"), "/c", cmd)
    system(cmd)
  })
  return()
}

block_list <- function(inputList, fill = "#7BEA7B"){ 
  # Use fill = NULL for regular recycling behavior 
  maxLen = max(sapply(inputList, length)) 
  for(i in seq_along(inputList)) 
    # inputList[[i]] <- c(inputList[[i]], rep(fill, maxLen - length(inputList[[i]]))) 
    inputList[[i]] <- c(
      rep(fill, length(inputList[[i]])),
      rep('white', maxLen - length(inputList[[i]]))
    )
  as.block(as.data.frame(inputList, stringsAsFactors = F))
} 

# y <- as.block(list(h = c(1, 2), m = 1:6))
# 
# dat <- block_grid(10, 10)
# 
# dat <- matrix("#7BEA7B", 10, 10)
# block_to_json(dat)
# 
block_to_json = function(x){
  UseMethod("block_to_json")
}

block_to_json.matrix <- function(x){
  dat = vector('list', NROW(x)*NCOL(x))
  m = 1
  for (j in 1:NCOL(x)){
    for (i in 1:NROW(x)){
      dat[[m]] <- list(i, j, x[i, j])
      m <- m + 1
    }
  }
  return(dat)
}

block_to_json.data.frame <- function(x){
  dat = vector('list', NROW(x)*NCOL(x))
  m = 1
  for (j in 1:NCOL(x)){
    for (i in 1:NROW(x)){
      dat[[m]] <- list(i, j, x[i, j])
      m <- m + 1
    }
  }
  return(dat)
}




