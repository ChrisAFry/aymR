# aymR

<img width="200" alt="aymR logo" src="https://user-images.githubusercontent.com/16511785/119430908-95affe00-bcdf-11eb-8648-eae410b9581a.png">

`aymR`, eponymously named after the greatest women's field hockey player, plots field hockey fields upon which location data (e.g. XY co-ordinates of shots) can be graphed.

## Prepare R

First, install the `devtools` package if you do not already have this.

```R
install.packages("devtools")
```

Now install the `aymR` package by downloading it from my GitHub.

```R
devtools::install_github("ChrisAFry/aymR")
``` 

Next, open `ggplot2` and `ggforce` (install using `install.packages("package")` before opening if you don't already have them) and `aymR`.

```R
library(ggplot2)
library(ggforce)
library(aymR)
```

## Plot some fields

`aymR` has 3 functions: plotting a field hockey field, plotting the top half of a field hockey field, and plotting the bottom half of a field hockey field. 

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

aymR field uses FIH dimensions - so the fields are 0-55 wide, and 0-91.4 tall. Therefore, your data must use the scale or you need to convert it before plotting.

ggplot2 works by layering components. Therefore, in most situations you will want to add the hockey field before you plot your data.

```R
mydata <- data.frame(x = c(26, 35, 27, 21, 20), y = c(89, 80, 78, 87, 82))
ggplot(mydata) + hockey_field("#bfbfbf", "#7CA867", "#ffffff", "#ffffff", .5, .75, 1) + geom_point(aes(x, y))
```
<img width="429" alt="Screen Shot 2021-02-13 at 1 49 33 PM" src="https://user-images.githubusercontent.com/16511785/107858514-81b45080-6e02-11eb-8c08-5d76614d1dd1.png">

## Companion ebook

If you are new to R, I have written an ebook on getting started with R, and how to use aymR to make beautiful charts. You can purchase it for just $10 at the link below:  

https://app.simplegoods.co/i/VXHRPELK

## Inspiration
These 2 packages for plotting soccer fields were helpful in developing my own package: <br/>
1 - https://github.com/Torvaney/ggsoccer <br/>
2 - https://github.com/FCrSTATS/SBpitch <br/>

