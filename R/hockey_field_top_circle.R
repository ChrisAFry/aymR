#' aymR
#'
#'Creates the top circle of a field hockey field, upon which data can be plotted (e.g. xy data of shots to create a shot chart)
#'
#' @param turf_color Color of the astroturf
#' @param line_color Color of the field lines (excluding the goals)
#' @param background_color Color of the plot background
#' @param goal_color Color of the goal post and crossbar lines
#' @param line_width Width of all the field lines
#' @param line_width Size of the penalty spots
#' @param turf_opacity Opacity of the turf
#'
#' @return
#' @export
#'
#' @examples
#' library(ggplot2)
#' library(ggforce)
#' mydata <- data.frame(x = c(26, 35, 27, 21, 20), y = c(89, 80, 78, 87, 82))
#'
#' ggplot(data = mydata) + hockey_field_top_circle("#ffffff", "#ffffff", "#A9A9A9", "#A9A9A9", .5, .75, 1) + geom_point(aes(x = x, y = y))

hockey_field_top_circle <- function(background_color, turf_color, line_color, goal_color, line_width, p_spot_size, turf_opacity){

  # Modify some theme elements (remove axis lines, labels etc.) and assign this to 'theme_blank_field' so that all that will be displayed when we make the charts will be the field hockey field
  theme_blank_field = function() {
    ggplot2::theme(
      plot.background = element_blank(),
      strip.background = element_rect(colour = background_color, fill = background_color, size = .5),
      panel.background = element_rect(fill = background_color, colour = background_color),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.spacing = unit(0, "pt"),
      legend.background = element_rect(fill = background_color, colour=NA),
      legend.position = "top",
      legend.key = element_rect(colour = background_color,fill = background_color),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.ticks.length = unit(0, "lines"),
      axis.title.x = element_blank(),
      axis.title.y = element_blank()
    )}

  # Set the size of the field
  ymin <- 75 # bottom
  ymax <- 91.4 # top baseline
  xmin <- 5.67 # left sideline
  xmax <- 49.33 # right sideline

  # Field markings (y axis)
  top_p_spot <- 84.925
  top_23 <- 68.5
  halfway_y <- 45.7
  bottom_23 <- 22.9
  bottom_p_spot <- 6.475

  # Field markings (x axis)
  halfway_x <- 27.5
  goal_post_left <- 25.67
  goal_post_right <- 29.33

  # Put it all togther and make the field
  hockey_field_top_circle <- list(
    # set the boundary of the plot, with some additional spacing
    ggplot2::xlim(c(xmin - 5, xmax + 5)),
    ggplot2::ylim(c(ymin - 5, ymax + 5)),
    # add the theme created above
    theme_blank_field(),
    # add the top baseline
    ggplot2::geom_segment(aes(x = xmin, y = ymax, xend = xmax, yend = ymax), colour = line_color, size = line_width, inherit.aes = FALSE),
    # add top penalty spot
    ggplot2::geom_point(aes(x = halfway_x, y = top_p_spot), colour = line_color, shape = 16, size = p_spot_size, inherit.aes = FALSE),
    # add the top goal crossbar
    ggplot2::geom_segment(aes(x = goal_post_left - 0, y = ymax + 2, xend = goal_post_right + 0, yend = ymax + 2), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the top goal left post
    ggplot2::geom_segment(aes(x = goal_post_left, y = ymax + 2, xend = goal_post_left, yend = ymax), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the top goal right post
    ggplot2::geom_segment(aes(x = goal_post_right, y = ymax + 2, xend = goal_post_right, yend = ymax), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the top circle
    ggforce::geom_arc(aes(x0 = 25.67, y0 = 91.4, start = -0.5 * pi, end = -1 * pi, r = 14.63), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggforce::geom_arc(aes(x0 = 29.33, y0 = 91.4, start = 0.5 * pi, end = 1 * pi, r = 14.63), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 25.67, y = 76.77, xend = 29.33, yend = 76.77), colour = line_color, size = line_width, inherit.aes = FALSE),
    # add the top 5m circle
    ggforce::geom_arc(aes(x0 = 25.67, y0 = 91.4, start = -0.5 * pi, end = -1 * pi, r = 19.63), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    ggforce::geom_arc(aes(x0 = 29.33, y0 = 91.4, start = 0.5 * pi, end = 1 * pi, r = 19.63), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 25.67, y = 71.77, xend = 29.33, yend = 71.77), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE)
  )

  return(hockey_field_top_circle)

}
