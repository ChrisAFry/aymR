# ayma_R

`ayma_R` plots field hockey fields, upon which location data (e.g. XY co-ordinates of shots) can be graphed.

## Prepare R

First, you will need to download the `ayma_R` package from my GitHub.

```R
devtools::install_github("ChrisAFry/ayma_R")
``` 

Next, open `ggplot2` and `ggforce` (install using `install.packages("package")` before opening if you don't already have them) and `ayma_R`.

```R
library(ggplot2)
library(ggforce)
library(ayma_R)
```

## Plot some fields

`ayma_R` has 3 functions: plotting a field hockey field, plotting the top half of a field hockey field, and plotting the bottom half of a field hockey field. 

Each function requires 7 inputs: background_color, turf_color, line_color, goal_color, line_width, p_spot_size, and turf_opacity. 
This seems excessive, but it is so that you have complete control over the look of the field that you want to plot.

```R
# Plot a grey background, with a green astroturf, white lines, white goals, line widths of .5, penalty spots of size .75 and no transparency of the astroturf.
ggplot() + hockey_field("#bfbfbf", "#7CA867", "#ffffff", "#ffffff", .5, .75, 1)
```
<img width="384" alt="Screen Shot 2021-02-13 at 1 40 20 PM" src="https://user-images.githubusercontent.com/16511785/107858211-1453f000-6e01-11eb-8a5c-e57d62eccb08.png">

Now lets plot the same field as above, but reduce the opacity of the turf.
```R
# Plot a grey background, with a green astroturf, white lines, white goals, line widths of .5, penalty spots of size .75 and 75% transparency of the astroturf.
ggplot() + hockey_field("#bfbfbf", "#7CA867", "#ffffff", "#ffffff", .5, .75, .25)
```
<img width="367" alt="Screen Shot 2021-02-13 at 2 27 26 PM" src="https://user-images.githubusercontent.com/16511785/107859515-f76eeb00-6e07-11eb-8a49-e72a34be4cd4.png">


```R
# Plot the top half of the field, with a grey background, a blue astroturf, white lines, a white goal, line widths of 2, penalty spots of size 2, and no transparency.
ggplot() + hockey_field_top_half("#bfbfbf", "#3a3de7", "#ffffff", "#ffffff", 2, 2, 1)
```
<img width="488" alt="Screen Shot 2021-02-13 at 1 41 49 PM" src="https://user-images.githubusercontent.com/16511785/107858255-51b87d80-6e01-11eb-8685-ed4773b20609.png">

```R
# Plot the bottom half of the field, with a black background, with black astroturf, pink lines, a blue goal, line widths of 1, penalty spots of size 2, and no transparency.
ggplot() + hockey_field_bottom_half("#060606", "#060606", "#ff00e7", "#00ecff", 1, 2, 1)
```
<img width="498" alt="Screen Shot 2021-02-13 at 1 43 15 PM" src="https://user-images.githubusercontent.com/16511785/107858292-86c4d000-6e01-11eb-8684-10fcc0544990.png">

## Plot data on a field

ggplot2 works by layering components. Therefore, in most situations you will want to add the hockey field before you plot your data.

```R
mydata <- data.frame(x = c(26, 35, 27, 21, 20), y = c(89, 80, 78, 87, 82))
ggplot(mydata) + hockey_field("#bfbfbf", "#7CA867", "#ffffff", "#ffffff", .5, .75, 1) + geom_point(aes(x, y))
```
<img width="429" alt="Screen Shot 2021-02-13 at 1 49 33 PM" src="https://user-images.githubusercontent.com/16511785/107858514-81b45080-6e02-11eb-8c08-5d76614d1dd1.png">

However, the turf opacity allows you to make the turf completely transparent so that only the lines of the field are visible (which you could then plot on top of your data). This will be great for heatmaps.
```R
# Imported an excel spreadsheet from my desktop called 'newdata', which had 2 columns: x, y.
ggplot(newdata) + stat_density_2d(aes(x, y, fill = ..density..), geom = "raster", contour = FALSE) + hockey_field("#bfbfbf", "#7CA867", "#ffffff", "#ffffff", .5, .75, 0)
```
<img width="604" alt="Screen Shot 2021-02-13 at 2 34 30 PM" src="https://user-images.githubusercontent.com/16511785/107859685-1b7efc00-6e09-11eb-8c2e-4bae5c5a055f.png">

## Inspiration
These 2 packages for plotting soccer fields were helpful in developing my own package: <br/>
1 - https://github.com/Torvaney/ggsoccer <br/>
2 - https://github.com/FCrSTATS/SBpitch <br/>

