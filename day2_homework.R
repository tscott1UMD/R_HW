# Complete all of the items below
# Use comments where you're having trouble or questions

# 1. Read your data set into R


load("~/Desktop/School/R/Final Project/Pathways data/baseline.rda")
pathbase <- da29961.0001
pathbase
colnames(pathbase)

# 2. Peek at the top few rows

head (pathbase)

# 3. Peek at the top few rows for only a few columns

head (pathbase[1:4])
head(pathbase[ , 1:4])
length(pathbase) - number of variables in dataset

# 4. How many rows does your data have?

pathbase[1]   shows that I have 1354 
nrow(pathbase)
length(pathbase$variable)

# 5. Get a summary for every column

summary(pathbase)

 # 6. Get a summary for one column

summary(pathbase$S0AGE)  
summary(pathbase[ , "S0AGE"])
summary(pathbase[ , c("S0AGE", "S0THN_R", "S0GEND")]) - multiple columns 

# 7. Are any of the columns giving you unexpected values?
#    - missing values? (NA)

Almost every column has a value of "NA." Foe example, there are 283 NA's in the SOTCO variables. 

# 8. Select a few key columns, make a vector of the column names

headervector <- c("CASEID", "S0AGE", "S0FAMSTR", "S0REL180")
colnames(pathbase)[headervector]

# 9. Create a new data.frame with just that subset of columns
#    from #7
#    - do this in at least TWO different ways

pathwayssubset <- data.frame(pathbase$CASEID, pathbase$S0AGE, pathbase$S0FAMSTR, pathbase$S0REL180)
pathwayssubset2 <- data.frame(CASEID = pathbase$CASEID, S0AGE = pathbase$S0AGE, S0FAMSTR=pathbase$S0FAMSTR, S0REL180=pathbase$S0REL180)
pathwayssubset3 <- pathbase[ , headervector] 

# 10. Create a new data.frame that is just the first 10 rows
#     and the last 10 rows of the data from #8

pathwaystop <- data.frame(pathwayssubset[1:10, ])
pathwaysbottom <- data.frame(pathwayssubset[1345:1354, ])
pathwayspeek <- rbind(pathwaystop, pathwaysbottom)

topandbottom <- pathbase[c(1:10, 1345:1354), ]

top <- head(pathbase, 10)
bottom <- tail(pathbase, 10)
top&bottom <- rbind(top, bottom)  - better because no numbers 

# 11. Create a new data.frame that is a random sample of half of the rows.

pathwaysrandom <- sample_n(pathwayspeek, 10, replace = FALSE, weight = NULL)

# 12. Find a comparison in your data that is interesting to make
#     (comparing two sets of numbers)
#     - run a t.test for that comparison
#     - decide whether you need a non-default test
#       (e.g., Student's, paired)
#     - run the t.test with BOTH the formula and "vector"
#       formats, if possible
#     - if one is NOT possible, say why you can't do it

Philadelphia <- pathbase$S0AGE [1:700]
Phoenix <- pathbase$S0AGE [701:1354]
t.test(Philadelphia, Phoenix)
t.test(Philadelphia, Phoenix, var.equal=TRUE, paired=FALSE)
I do not need a paired since I am comparing 2 different samples, but I did switch to the Student's t-test because age is normally distributed and the group variances are similar 
t.test(S0AGE~S0SITE, data=pathbase)


# 13. Repeat #10 for TWO more comparisons
#     - ALTERNATIVELY, if correlations are more interesting,
#       do those instead of t-tests (and try both Spearman and
#       Pearson correlations)

anxiety <- pathbase$S0BSIANX
depression <- pathbase$S0BSIDEP
cor(anxiety, depression, use = "complete.obs", method = c("pearson")) 
cor(anxiety, depression, use = "complete.obs", method = c("spearman"))

males <- pathbase$S0REL149[pathbase$S0SGEND == 1]
females <- pathbase$S0REL149[pathbase$S0SGEND == 2]
* I was trying to make these groups, and then examine whether males or females were more likely to report ever running away using a chi-saquared test (chisq.test(x, y). I cannot get this group formation method to work though, even though it worked for me with the sleep data during the practice. I left it in in hopes you might have a solution)


# 14. Save all results from #12 and #13 in an .RData file

welchttest <- t.test(Philadelphia, Phoenix)
Studentttest <- t.test(Philadelphia, Phoenix, var.equal=TRUE, paired=FALSE)
formula <- t.test(S0AGE~S0SITE, data=pathbase)
pearson <-cor(anxiety, depression, use = "complete.obs", method = c("pearson")) 
spearman <- cor(anxiety, depression, use = "complete.obs", method = c("spearman"))
save(welchttest, Studentttest, formula, pearson, spearman, file = "hw2t-tests.RData")

# 15. Email me your version of this script, PLUS the .RData
#     file from #14
