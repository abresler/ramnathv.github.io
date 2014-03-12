BlockGrid = setRefClass('BlockGrid', fields = c('nrow', 'ncol', 'type', 'data'), 
  methods = list(
    initialize = function(nrow, ncol = nrow, type = 'data.frame'){
      options(stringsAsFactors = FALSE)
      data_ = matrix("#7BEA7B", nrow, ncol)
      data <<- switch(type,
        "data.frame" = as.data.frame(data_, stringsAsFactors = F),
        "data.table" = {library(data.table); data.table(data_)},
        "matrix" = data_
      )
    },
    reset = function(){
      data[] <<- "#7BEA7B"
    },
    show = function(){
      # code stolen from sna::plot.sociomatrix
      n = dim(data)[1]; o = dim(data)[2]
      drawlines = TRUE
      cur_mar = par('mar')
      par(mar = c(0.5, 0.5, 0.5, 0.5))
      colors_ = c('#7BEA7B', 'red')
      plot(1, 1, xlim = c(0, o + 1), ylim = c(n + 1, 0), type = "n",
        axes = FALSE, xlab = "", ylab = ""
      )
      for (i in 1:n){
        for (j in 1:o) {
          rect(j - 0.5, i + 0.5, j + 0.5, i - 0.5, 
            col = data[i, j], xpd = TRUE, border = 'white'
          )
        }
      }
      rect(0.5, 0.5, o + 0.5, n + 0.5, col = NA, xpd = TRUE, border = 'white')
      par(mar = cur_mar)
    }
))

