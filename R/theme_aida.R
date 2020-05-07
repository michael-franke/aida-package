#' ggplot2 theme for the AIDA course
#' 
#' @param title.size title element size in pts
#' @param text.size text element size in pts
#' @param legend.position either one of "none", "left", "right", "bottom", "top"
#' @param show.axis boolean or "x", "y"; should axis be drawn? Which?
#' @param show.grid boolean; should grid lines be drawn?
#' @param plot.margin margin around entire plot (unit with the sizes of the top, right, bottom, and left margins)
#' 
#' @import ggplot2
#' @export
theme_aida <- function(title.size = 16, text.size = 14, legend.position = "top", 
                       show.axis = FALSE, show.grid = TRUE,
                       plot.margin = c(.2, .1, .2, .1)){
  # baseline
  layout <- theme_classic()
  layout <- layout + theme(text = element_text(size = text.size),
                           title = element_text(size = title.size, 
                                                face = "bold"),
                           line = element_line(size = .5))
  
  # axis
  if (inherits(show.axis, "character") | show.axis == FALSE){
    if (inherits(show.axis, "character")){
      show.axis <- tolower(show.axis)
      if (show.axis == "x"){
        layout <- layout + theme(axis.line.y = element_blank())
      }
      if (show.axis == "y"){
        layout <- layout + theme(axis.line.x = element_blank())
      }
    } else {
      layout <- layout + theme(axis.line.x = element_blank(),
                               axis.line.y = element_blank())
    }
  }
  
  # grid lines
  if (show.grid == TRUE){
    layout <- layout + theme(panel.grid.major = element_line(size = .2, 
                                                             color = "#333333", 
                                                             linetype = "dotted"))
  }
  
  # axis titles
  layout <- layout + theme(axis.title.x = element_text(margin = margin(t = 8)))
  
  # legend
  layout <- layout + theme(legend.position = legend.position,
                           legend.background = element_blank(),
                           legend.key.height = unit(2, "line"))
  
  # facets 
  layout <- layout + theme(strip.background = element_blank(),
                           strip.text = element_text(size = title.size,
                                                     face = "bold"))
  
  # misc 
  layout <- layout + theme(panel.background = element_rect(fill = "white"),
                           plot.background = element_rect(fill = "white"),
                           plot.margin = unit(plot.margin, "cm"))
  
  layout
}
