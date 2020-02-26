library(ggplot2)

# I_Jean
I_jean <- read.delim("http://bit.ly/avml_ggplot2_data")
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_log10(breaks = c(50, 100,200,300,400))+
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme_bw()+
  ggtitle("394 tokens of 'I' from one speaker")

# the data layer

# example 1
head(I_jean)

# example 2
p <- ggplot(I_jean, aes(x = Dur_msec, y = F1.n))

# the geometries layer

# example 1
p <- p + geom_point()
p

# example 2
ggplot(I_jean, aes(x=Dur_msec, y=F1.n)) +
  geom_point(shape = 3)

# example 3
ggplot(I_jean, aes(x=Dur_msec, y=F1.n)) +
  geom_point(color = "red", size = 3)

# the statistics layer

# example 1
p <- p + stat_smooth()
p

# example 2
ggplot(I_jean, aes(x = Dur_msec, y = F1.n))+
  stat_smooth()

# scale transformations

# example 1
p <- p + scale_x_log10(breaks = c(50, 100,200,300,400))+
  scale_y_reverse()
p


# cosmetic alterations

# example 1
p <- p + ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme_bw()+
  ggtitle("394 tokens of 'I' from one speaker")
p

# example 2
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_log10(breaks = c(50, 100,200,300,400))+
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme_bw()+
  ggtitle("394 tokens of 'I' from one speaker")

# aesthetics

# example 1
I_subset <- subset(I_jean, Word != "I")

ggplot(I_subset, aes(Dur_msec, F1.n, color = Word))+
  geom_point()

# example 2
ggplot(I_subset, aes(Dur_msec, F1))+
  geom_point(color = "red")

# example 3
I_subset$Color <- c("black",
                    "red","blue",
                    "green","goldenrod")[I_subset$Word]

ggplot(I_subset, aes(Dur_msec, F1, color = Color))+
  geom_point()

# inhertiance

# example 1
ggplot(I_subset, aes(Dur_msec, F1.n, color = Word))+
  geom_point()+
  geom_line()

# example 2
ggplot(I_subset, aes(Dur_msec, F1.n))+
  geom_point(aes(color = Word))+
  geom_line()

# example 3
ggplot(I_subset, aes(Dur_msec, F1.n))+
  geom_point()+
  geom_line( aes(color = Word))+
  scale_color_hue(direction = -1)

# grouping

# example 1
ggplot(I_subset, aes(Dur_msec, F1.n, color=Word))+
  geom_point()+
  stat_smooth(se = F)

# example 2
ggplot(I_subset, aes(Dur_msec, F1.n))+
  geom_point(aes(color=Word))+
  stat_smooth(se = F)

# example 3
ggplot(I_subset, aes(Dur_msec, F1.n, shape=Word))+
  geom_point()

# example 4
ggplot(I_subset, aes(Dur_msec, F1.n, shape=Word))+
  geom_point()+
  stat_smooth(se = F)

# example 5
ggplot(I_subset, aes(Dur_msec, F1.n, shape=Word))+
  geom_point()+
  stat_smooth(se = F, aes(group = 1))

# example 6
ggplot(I_subset, aes(Dur_msec, F1.n, color=Word))+
  geom_line(aes(group = 1))

# more aesthetics and their use


# example 1
ggplot(I_jean, aes(Dur_msec, F1.n, color = F1.n))+
  geom_point()

# example 2
ggplot(I_jean, aes(Word))+
  geom_bar()

# example 3
ggplot(I_jean, aes(Word, color = Word))+
  geom_bar()

# example 4
ggplot(I_jean, aes(Word, fill = Word))+
  geom_bar()

# example 5
ggplot(I_subset, aes(Name, fill = Word))+
  geom_bar()

# example 6
ggplot(I_subset, aes(Name, fill = Word))+
  geom_bar(color = "black")

# geometries

# example 1
apropos("^geom_")

# example 2
ggplot(I_jean, aes(F1.n))+
  geom_histogram()

# example 3
ggplot(I_jean, aes(Dur_msec, F1.n))+
  geom_smooth()

# some special geoms

# geom_line() vs geom_path()

# example 1
mod_F1 <- loess(F1.n ~ Dur_msec, data = I_jean)
mod_F2 <- loess(F2.n ~ Dur_msec, data = I_jean)

pred <- data.frame(Dur_msec = seq(50, 400, length = 100))
pred$F1.n <- predict(mod_F1, newdata = pred)
pred$F2.n <- predict(mod_F2, newdata = pred)

ggplot(pred, aes(-F2.n, -F1.n, color = Dur_msec))+
  geom_path()+
  geom_point()

# example 2 
ggplot(pred, aes(-F2.n, -F1.n, color = Dur_msec))+
  geom_line()+
  geom_point()

# geom_text()

# example 1
ggplot(I_subset, aes(Dur_msec, F1.n))+
  geom_text(aes(label = Word))

# jitter

# example 1
ggplot(I_jean, aes(Word, F1.n))+
  geom_boxplot()

# example 2
ggplot(I_jean, aes(Word, F1.n))+
  geom_point()

# example 3
ggplot(I_jean, aes(Word, F1.n))+
  geom_point(position = "jitter")

# example 4
ggplot(I_jean, aes(Word, F1.n))+
  geom_jitter()

# dodge, stack, and fill

# example 1
I_subset$Dur_cat <- I_subset$Dur_msec > mean(I_subset$Dur_msec)

ggplot(I_subset, aes(Dur_cat))+
  geom_bar()

# example 2
ggplot(I_subset, aes(Dur_cat, fill = Word))+
  geom_bar(color = "black")

# example 3
ggplot(I_subset, aes(Dur_cat, fill = Word))+
  geom_bar(position = "dodge", color = "black")

# example 4
ggplot(I_subset, aes(Dur_cat, fill = Word))+
  geom_bar(position = "fill", color = "black")

# example 5
ggplot(I_subset, aes(Word, fill = Dur_cat))+
  geom_bar(position = "fill", color = "black")

# example 6
ggplot(I_subset, aes(Dur_msec, fill = Word))+
  geom_density(alpha = 0.6)

# example 7
ggplot(I_subset, aes(Dur_msec, fill = Word))+
  geom_density(position = "stack", aes(y = ..count..))

# example 8
ggplot(I_subset, aes(Dur_msec, fill = Word))+
  geom_density(position = "fill", aes(y = ..count..))

# some new exciting geoms

# example 1
ggplot(I_subset, aes(Word, F1.n))+
  geom_violin()+
  geom_dotplot(binaxis="y", stackdir="center")

# statistics

# example 1
apropos("^stat_")

# example 2
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth()

# example 3
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth(geom = "point")

# example 4
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth(geom = "pointrange")

# example 5
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  geom_point()

# example 6
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  geom_point(stat = "smooth")

# example 7
geoms <- gsub("geom_", "", apropos("^geom_"))
stats <- gsub("stat_", "", apropos("^stat_"))

stats[stats %in% geoms]

# particularly useful statistics

# stat_smooth()

# example 1
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth()

# example 2
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth(method = lm)

# example 3
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth(method = lm, formula = y ~ poly(x, 3))

# example 4
library(splines)
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth(method = lm, formula = y ~ bs(x, df = 10))

# example 5
library(mgcv)
ggplot(I_jean, aes(Dur_msec, F1.n)) + 
  stat_smooth(method = gam, formula = y ~ s(x, bs = "cs"))

# example 6
I_jean$F1_median <- (I_jean$F1.n > median(I_jean$F1.n)) * 1
head(I_jean)

# example 7
ggplot(I_jean, aes(Dur_msec, F1_median))+
  stat_smooth(method = glm, family = binomial)

# b-splines
# example 1
ggplot(I_jean, aes(Dur_msec, F1_median))+
  stat_smooth(method = glm, 
              family = binomial, 
              formula  = y ~ bs(x, df = 10))

# cubic regression splines
# example 1
ggplot(I_jean, aes(Dur_msec, F1_median))+
  stat_smooth(method = gam, 
              family = binomial, 
              formula  = y ~ s(x, bs = "cs"))

# stat_summary()

# example 1
ggplot(I_jean, aes(Word, Dur_msec))+
  stat_summary(fun.y = mean, geom = "bar")

# example 2
ggplot(I_jean, aes(Word, Dur_msec))+
  stat_summary(fun.y = mean, geom = "bar", fill = "grey40")+
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar")

# example 3
ggplot(I_jean, aes(Word, Dur_msec))+
  stat_summary(fun.y = mean, geom = "bar", fill = "grey40")+
  stat_summary(fun.data = mean_cl_boot, geom = "pointrange")

# example 4
ggplot(I_jean, aes(Dur_msec, color = Word))+
  geom_density()

# example 5
ggplot(I_jean, aes(Dur_msec, color = Word))+
  geom_density(aes(y = ..count..))

# example 6
ggplot(I_jean, aes(Dur_msec, fill = Word))+
  geom_density(aes(y = ..count..), position = "fill")

# example 7
ggplot(I_jean, aes(Dur_msec, fill = Word))+
  geom_density(aes(y = ..density..), position = "fill")

# example 8
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d()

# example 9
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "polygon", aes(fill = ..level..))

# example 10
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "point",contour = F, 
                 aes(size = ..density..), alpha = 0.3)

# example 11
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile", contour = F, aes(alpha = ..density..))

# example 12
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile", contour = F, aes(fill = ..density..))

# x and y scales

# example 1
apropos("^scale_x_")

# scale_[xy]_continuous

# example 1
ggplot(I_jean, aes(Dur_msec, F1.n))+
  geom_point()

# example 2
ggplot(I_jean, aes(Dur_msec, F1.n))+
  geom_point()+
  scale_x_continuous(name = "Vowel Duration (msec)")

# example 3
ggplot(I_jean, aes(Dur_msec, F1.n))+
  geom_point()+
  xlab("Vowel Duration (msec)")

# example 4
ggplot(I_jean, aes(log2(Dur_msec), F1.n))+
  geom_point()+
  scale_x_continuous("log2 Vowel Duration (msec)")

# example 5
ggplot(I_jean, aes(Dur_msec, F1.n))+
  geom_point()+
  scale_x_continuous("Vowel Duration (msec)",
                     trans = "log2")

# example 6 
apropos("_trans")

# example 7
ggplot(I_jean, aes(Dur_msec, F1.n))+
  geom_point()+
  scale_x_continuous("Vowel Duration (msec)",
                     trans = "sqrt")

# example 8
ggplot(I_jean, aes(Dur_msec, F1.n))+
  geom_point()+
  scale_x_continuous("Vowel Duration (msec)",
                     trans = "reverse")

# color and fill scales
apropos("^scale_color_")

# categorical color scales

# example 1
ggplot(I_jean, aes(Word, Dur_msec, fill = Word))+
  stat_summary(fun.y = mean, geom = "bar")+
  scale_fill_hue()

# example 2
ggplot(I_jean, aes(Word, Dur_msec, fill = Word))+
  stat_summary(fun.y = mean, geom = "bar")+
  scale_fill_hue(name = "Lexical Item",
                 limits = c("I'D","I'VE","I'LL","I'M","I"),
                 labels = c("'D","'VE","'LL","'M",""))

# example 3
ggplot(I_jean, aes(Word, Dur_msec, fill = Word))+
  stat_summary(fun.y = mean, geom = "bar")+
  scale_fill_brewer(palette = "Set1")

# example 4
ggplot(I_jean, aes(Word, Dur_msec, fill = Word))+
  stat_summary(fun.y = mean, geom = "bar")+
  scale_fill_manual(values=c("bisque", "chartreuse4",
                             "hotpink","yellow", "red"))

# example 5
ggplot(I_jean, aes(Word, Dur_msec, fill = Word))+
  stat_summary(fun.y = mean, geom = "bar")+
  scale_fill_grey()

# gradient color scales

# example 1
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradient()

# example 2
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradient(low="darkblue",high="darkred")

# example 3
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradient2(low="darkblue",
                       high="darkred",
                       mid="white",
                       midpoint=0.5)

# example 4
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradientn(colours = c("bisque", "chartreuse4",
                                   "hotpink","yellow"))

# example 5
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradientn(colours = rainbow(6))

# example 6
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradientn(colours = terrain.colors(6))

# example 7
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradientn(colours = topo.colors(6))

# guides

# example 1
ggplot(I_jean, aes(-F2.n, -F1.n))+
  stat_density2d(geom = "tile",contour = F, aes(fill = ..density..))+
  scale_fill_gradientn(colours = rainbow(6),
                       guide = "colorbar")

# shape and linetype

# example 1
apropos("^scale_shape_")

# example 2
apropos("^scale_linetype_")

# example 3 
ggplot(I_subset, aes(Dur_msec, F1.n, shape = Word))+
  geom_point()

# example 4
ggplot(I_subset, aes(Dur_msec, F1.n, shape = Word))+
  geom_point()+
  scale_shape_manual(values=c(1,1, 19, 19))

# other scales

# example 1
apropos("^scale_size_")

# example 2
apropos("^scale_alpha_")

# more on guides

# example 1
ggplot(I_subset, aes(Dur_msec, F1.n, 
                     color = Word,
                     shape = Word, 
                     linetype = Word))+
  geom_point()+
  geom_line()

# example 2
ggplot(I_subset, aes(Dur_msec, F1.n, 
                     color = Word, 
                     shape = Word, 
                     linetype = Word))+
  geom_point()+
  geom_line()+
  scale_color_hue(guide = F)

# example 3
ggplot(I_subset, aes(Dur_msec, F1.n, color = Word, label = Word))+
  geom_text()+
  geom_line()

# example 4
ggplot(I_subset, aes(Dur_msec, F1.n, color = Word, label = Word))+
  geom_text(show_guide = F)+
  geom_line()

# faceting

# example 1
I_jean$Dur_cat <- I_jean$Dur_msec > mean(I_jean$Dur_msec)

# facet_wrap

# example 1
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()

# example 2
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_wrap(~Word)

# example 3
ggplot(I_jean, aes(Dur_cat, F1.n))+
  stat_summary(fun.data = mean_cl_boot)+
  facet_wrap(~Word)

# example 4
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_wrap(~Word, ncol = 2)

# example 5
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_wrap(~Word, nrow = 1)

# example 6
# Inadvisable
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_wrap(~Word, scales = "free_x")

# example 7
# Inadvisable
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_wrap(~Word, scales = "free_y")

# example 8
# Inadvisable
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_wrap(~Word, scales = "free")

# facet_grid

# example 1
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_grid(Dur_cat~Word)

# example 2
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_grid(Word~Dur_cat)

# example 3
ggplot(I_jean, aes(-F2.n, -F1.n ))+
  geom_point()+
  facet_grid(Dur_cat~Word, scales = "free")

# additional options

# example 1
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme_grey()

# example 2
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme_grey(base_size = 16, base_family = "serif")

# example 3
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme_grey(base_size = 16, base_family = "mono")

# example 4
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme_bw()

# example 5
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme(panel.background = element_rect(colour = 'purple', 
                                        fill = 'pink', 
                                        size = 3, 
                                        linetype='dashed'))

# example 6
ggplot(I_jean, aes(x=Dur_msec, y=F1.n))+
  geom_point()+
  stat_smooth()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  ggtitle('Plot of "I"')

# example 7
ggplot(I_jean, aes(x=Dur_msec, y=F1.n, color = Word))+
  geom_point()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  scale_color_brewer(palette = "Set1")+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme(legend.position = "right")


# example 8
ggplot(I_jean, aes(x=Dur_msec, y=F1.n, color = Word))+
  geom_point()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  scale_color_brewer(palette = "Set1")+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme(legend.position = "top")

# example 9
ggplot(I_jean, aes(x=Dur_msec, y=F1.n, color = Word))+
  geom_point()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  scale_color_brewer(palette = "Set1")+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme(legend.position = c(0.9,0.5))

# example 10
ggplot(I_jean, aes(x=Dur_msec, y=F1.n, color = Word))+
  geom_point()+
  scale_x_continuous(trans = "log2")+ 
  scale_y_reverse()+
  scale_color_brewer(palette = "Set1")+
  ylab("Normalized F1")+
  xlab("Vowel duration (msec)")+
  theme(legend.position = "none")

# building plots

# example 1
library(plyr)
word_means <- ddply(I_jean, .(Word), numcolwise(mean))

ggplot(I_subset, aes(F2.n, F1.n, color = Word)) + 
  geom_point()+
  geom_text(data = word_means, 
            aes(label = Word),
            show.legend = F)+
  scale_y_reverse()+
  scale_x_reverse()+
  coord_fixed()

# example 2
fdw <- read.delim("http://bit.ly/fdw_2005")
head(fdw)

# example 3
fdw <- ddply(fdw, .(Child), transform, prob = value/sum(value))

ggplot(fdw, aes(Age/12, fill = variable)) + 
  geom_density(aes(weight = prob, y = ..count..), position = "fill")+
  facet_wrap(~Sex)+
  scale_fill_brewer(name = "variant", palette = "Set1")+
  theme_bw()

# additional notes on the structure of the complete 23andMe file

SNPs<- read.table("23andMe_complete.txt", header = TRUE, sep = "\t")
str(SNPs)

class(SNPs)

typeof(SNPs)

str(SNPs)

summary(SNPs)

class(SNPs$genotype)

typeof(SNPs$genotype)

str(SNPs$genotype)

summary(SNPs$genotype)

summary(SNPs$chromosome)

summary(SNPs$position)

SNPs$chromosome = ordered(SNPs$chromosome, levels=c(seq(1, 22), "X", "Y", "MT"))
summary(SNPs$chromosome)

# exercises

# exercise 1
SNPs<- read.table("23andMe_complete.txt", header = TRUE, sep = "\t")
p<- ggplot(SNPs,aes(chromosome))+
  geom_bar()
p

# exercise 2
SNPs$chromosome = ordered(SNPs$chromosome, levels=c(seq(1, 22), "X", "Y", "MT"))
p<- ggplot(SNPs,aes(chromosome))+
  geom_bar()
p

# exercise 3
ggplot(SNPs,aes(chromosome, fill = genotype))+
  geom_bar(color = "black")

# exercise 4
ggplot(SNPs,aes(chromosome, fill = genotype))+
  geom_bar(position = "fill", color = "black")

# exercise 5
ggplot(SNPs, aes(chromosome, fill = genotype))+
  geom_bar(position = "dodge")

# exercise 6
ggplot(SNPs, aes(chromosome, fill = genotype))+
  geom_bar(position = "dodge") + 
  facet_wrap(~genotype)