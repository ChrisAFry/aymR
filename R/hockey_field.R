#' aymR
#'
#'Creates a field hockey field, upon which data can be plotted (e.g. xy data of shots to create a shot chart)
#'
#' @param turf_color Color of the astroturf
#' @param line_color Color of the field lines (excluding the goals)
#' @param background_color Color of the plot background
#' @param goal_color Color of the goal post and crossbar lines
#' @param line_width Width of all the field lines
#' @param p_spot_size Size of the penalty spots
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
#' ggplot(data = mydata) + hockey_field("#ffffff", "#ffffff", "#A9A9A9", "#A9A9A9", .5, .75, 1) + geom_point(aes(x = x, y = y))

hockey_field <- function(background_color, turf_color, line_color, goal_color, line_width, p_spot_size, turf_opacity){

  # Modify some theme elements (remove axis lines, labels etc.) and assign this to 'theme_blank_field' so that all that will be displayed when we make the charts will be the field hockey field
  theme_blank_field = function() {
    ggplot2::theme(
      plot.background = element_rect(fill = background_color),
      strip.background = element_rect(fill = background_color),
      panel.background = element_rect(fill = background_color),
      panel.border = element_blank(),
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
      )
  }

  # Set the size of the field
  ymin <- 0 # bottom baseline
  ymax <- 91.4 # top baseline
  xmin <- 0 # left sideline
  xmax <- 55 # right sideline

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

  # Put it all together and make the field
  hockey_field <- list(
    # set the boundary of the plot, with some additional spacing
    ggplot2::xlim(c(xmin - 5, xmax + 5)),
    ggplot2::ylim(c(ymin - 5, ymax + 5)),
    # add the theme created above
    theme_blank_field(),
    # add the baselines and sidelines
    ggplot2::geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = turf_color, alpha = turf_opacity, colour = line_color, size = line_width, inherit.aes = FALSE),
    # add the top 23m line
    ggplot2::geom_segment(aes(x = xmin, y = top_23, xend = xmax, yend = top_23), colour = line_color, size = line_width, inherit.aes = FALSE),
    # add the half way line
    ggplot2::geom_segment(aes(x = xmin, y = halfway_y, xend = xmax, yend = halfway_y), colour = line_color, size = line_width, inherit.aes = FALSE),
    # add the bottom 23m line
    ggplot2::geom_segment(aes(x = xmin, y = bottom_23, xend = xmax, yend = bottom_23), colour = line_color, size = line_width, inherit.aes = FALSE),
    # add top penalty spot
    ggplot2::geom_point(aes(x = halfway_x, y = top_p_spot), colour = line_color, shape = 16, size = p_spot_size, inherit.aes = FALSE),
    # add bottom penalty spot
    ggplot2::geom_point(aes(x = halfway_x, y = bottom_p_spot), colour = line_color, shape = 16, size = p_spot_size, inherit.aes = FALSE),
    # add the top goal crossbar
    ggplot2::geom_segment(aes(x = goal_post_left - 0, y = ymax + 2, xend = goal_post_right + 0, yend = ymax + 2), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the top goal left post
    ggplot2::geom_segment(aes(x = goal_post_left, y = ymax + 2, xend = goal_post_left, yend = ymax), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the top goal right post
    ggplot2::geom_segment(aes(x = goal_post_right, y = ymax + 2, xend = goal_post_right, yend = ymax), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the bottom goal crossbar
    ggplot2::geom_segment(aes(x = goal_post_left - 0, y = ymin - 2, xend = goal_post_right + 0, yend = ymin - 2), colour = goal_color, inherit.aes = FALSE),
    # add the bottom goal left post
    ggplot2::geom_segment(aes(x = goal_post_left, y = ymin - 2, xend = goal_post_left, yend = ymin), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the bottom goal right post
    ggplot2::geom_segment(aes(x = goal_post_right, y = ymin - 2, xend = goal_post_right, yend = ymin), colour = goal_color, size = line_width, inherit.aes = FALSE),
    # add the top circle
    ggforce::geom_arc(aes(x0 = 25.67, y0 = 91.4, start = -0.5 * pi, end = -1 * pi, r = 14.63), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggforce::geom_arc(aes(x0 = 29.33, y0 = 91.4, start = 0.5 * pi, end = 1 * pi, r = 14.63), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 25.67, y = 76.77, xend = 29.33, yend = 76.77), colour = line_color, size = line_width, inherit.aes = FALSE),
    # add the bottom circle
    ggforce::geom_arc(aes(x0 = 25.67, y0 = 0, start = 1.5 * pi, end = 2 * pi, r = 14.63), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggforce::geom_arc(aes(x0 = 29.33, y0 = 0, start = -1.5 * pi, end = -2 * pi, r = 14.63), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 25.67, y = 14.63, xend = 29.33, yend = 14.63), colour = line_color, size = line_width, inherit.aes = FALSE),
    # add the top 5m circle
    ggforce::geom_arc(aes(x0 = 25.67, y0 = 91.4, start = -0.5 * pi, end = -1 * pi, r = 19.63), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    ggforce::geom_arc(aes(x0 = 29.33, y0 = 91.4, start = 0.5 * pi, end = 1 * pi, r = 19.63), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 25.67, y = 71.77, xend = 29.33, yend = 71.77), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    # add the bottom 5m circle
    ggforce::geom_arc(aes(x0 = 25.67, y0 = 0, start = 1.5 * pi, end = 2 * pi, r = 19.63), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    ggforce::geom_arc(aes(x0 = 29.33, y0 = 0, start = -1.5 * pi, end = -2 * pi, r = 19.63), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 25.67, y = 19.63, xend = 29.33, yend = 19.63), colour = line_color, linetype = "dashed", size = line_width, inherit.aes = FALSE),
    ## Top circle marks
    ggplot2::geom_segment(aes(x = 15.67, y = 91.4, xend = 15.67, yend = 91.9), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 20.67, y = 91.4, xend = 20.67, yend = 91.9), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 34.33, y = 91.4, xend = 34.33, yend = 91.9), colour = line_color, size = line_width, inherit.aes = FALSE, ),
    ggplot2::geom_segment(aes(x = 39.33, y = 91.4, xend = 39.33, yend = 91.9), colour = line_color, size = line_width, inherit.aes = FALSE),
    ## Bottom circle marks
    ggplot2::geom_segment(aes(x = 15.67, y = 0, xend = 15.67, yend = -0.5), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 20.67, y = 0, xend = 20.67, yend = -0.5), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 34.33, y = 0, xend = 34.33, yend = -0.5), colour = line_color, size = line_width, inherit.aes = FALSE),
    ggplot2::geom_segment(aes(x = 39.33, y = 0, xend = 39.33, yend = -0.5), colour = line_color, size = line_width, inherit.aes = FALSE)
  )

  return(hockey_field)

}
