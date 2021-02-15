Data Practices:

I’m honestly not sure what to include in here, I’ll take a shot.

Process:

1.  Download and unzip the file, IF you haven’t already installed it
2.  Figure out the parts and pieces of the data jigsaw puzzle. I had
    some mixed feelings about this, but I decided to row bind between
    the test and training data, then install the features over that
    after column binding the index, activity type, and everything else.
3.  This combined dataframe was named Thanos.
4.  I then made a new tibble (dataframe) specific, that had the
    means/stdev conditions applied.
5.  I tidied up the names, changed the activity number-maps to their
    actual activity counterpart in the activity type column (named
    ?exerType?)
6.  I then grouped by the identifying participant index and the exercise
    type and calculated the means.
7.  With the calculations done, I return a dataframe that has everything
    good to go.

Guess I’m done. That had some challenging parts to it, figuring out how
the pieces fit together was downright impossible before realizing that
they literally gave us a bunch of data we weren’t instructed to use.
Also, if you open up files like Xtrain in excel, you won’t realize the
real dimensions until loading them into Rstudio as a table and actually
dim-ing them. I felt like an idiot after realizing the dimensions were
completely different on that.
