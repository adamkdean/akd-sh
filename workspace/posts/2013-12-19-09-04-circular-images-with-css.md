---

We'll use this picture of [William Shakespeare](http://i.imgur.com/jZN7xit.jpg).

    .circular {
        width: 300px;
        height: 300px;
        border-radius: 150px;
        -webkit-border-radius: 150px;
        -moz-border-radius: 150px;
    }


    <!-- regular image -->
    <img src="http://i.imgur.com/jZN7xit.jpg">

    <!-- circular image -->
    <img src="http://i.imgur.com/jZN7xit.jpg" class="circular">

And the output:

![Circular images with CSS](http://i.imgur.com/UgACoIw.png)

One thing to bear in mind is that **the border-radius must be half the height and width** in order to make the image circular. Width & height equal 300px, border-radius equals 150px. Width & height equal 600px, border-radius equals 300px.