---
layout: page
title: Maya 
description: Projects I've done in Maya; Animation, Character Rigging 
img:
importance: 3
category: design
---

Here are the projects I've done in Maya. I've explored a couple mediums: Animation, Character Rigging and Design. 

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include video.liquid path="assets/img/MayaContent/Toayo_Onajobi_Final_Movie.mp4"  width="800px" height="450px" controls=true %}
    </div>
</div>
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include video.liquid path="assets/img/MayaContent/hw1.mp4"  width="800px" height="450px" controls=true %}
    </div>
</div>
<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include video.liquid path="assets/img/MayaContent/Toayo_Onajobi_Movie.mp4"  width="800px" height="450px" controls=true %}
    </div>
</div>

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/CentaurFullRig.png" title="example image" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    A full character rig I was required to develop for my Character Rigging class.
</div>


<div class="row justify-content-sm-center">
    <div class="col-sm-8 mt-3 mt-md-0">
       {% include video.liquid path="assets/img/MayaContent/blastVNEdOw.mp4"  width="800px" height="450px" controls=true %}
    </div>
</div>

<div class="row">
    <div class="col-sm-4 mt-3 mt-md-0">
        {% include video.liquid path="assets/img/MayaContent/Assignment1_Toayo_Onajobi.mp4" width="800px" height="450px" controls=true %}
    </div>
</div>

<div class="row">
    <div class="col-sm-4 mt-3 mt-md-0">
        {% include video.liquid path="assets/img/MayaContent/guy_push_up_animation.mp4" width="800px" height="450px" controls=true %}
    </div>
</div>

The code is simple.
Just wrap your images with `<div class="col-sm">` and place them inside `<div class="row">` (read more about the <a href="https://getbootstrap.com/docs/4.4/layout/grid/">Bootstrap Grid</a> system).
To make images responsive, add `img-fluid` class to each; for rounded corners and shadows use `rounded` and `z-depth-1` classes.
Here's the code for the last row of images above:

{% raw %}

```html
<div class="row justify-content-sm-center">
  <div class="col-sm-8 mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/6.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
  </div>
  <div class="col-sm-4 mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/11.jpg" title="example image" class="img-fluid rounded z-depth-1" %}
  </div>
</div>
```

{% endraw %}
