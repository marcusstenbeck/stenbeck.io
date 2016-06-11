---
layout: post
title: "Writing my first Yeoman generator"
date: 2015-01-03 13:48:10 +0100
comments: true
categories: 
---

Yeoman is a guy that waits for you to make him do stuff. Recently I thought that it might be useful to create a Yeoman generator that bootstraps canvas animation projects, [like those I've been twiddling with lately](http://codepen.io/marcusstenbeck/public/). In this article I go through the basics of putting together a simple Yeoman generator that copies a few template files into a new project folder.

The general idea is to run one command, like the one below, to generate a basic structure ready for you to start working with.

``` bash
$ yo loop-sketch my-sketch
```

<!-- more -->

## My base code

*The generator I'm making is very specific to the type of tiny projects I enjoy working on, but it's really easy to adapt this to any other code.*

I enjoy [creating animated and sometimes interactive JavaScript sketches](http://codepen.io/marcusstenbeck/public/). Every sketch I make contains some base code that sets up the animation loop and defines a few functions that I commonly use to update my sketch and then draw it. You can see the code below.

``` html index.html
<!-- index.html -->

<!DOCTYPE html>
<html>
<head>
	<title>Sketch</title>
	<style type="text/css">
		body {
			margin: 0;
			padding: 0;
			background-color: black;
		}
	</style>
</head>
<body>

<script type="text/javascript" src="js/app.js"></script>

</body>
</html>
```

``` javascript app.js
/**
 *  js/app.js
 */

// Create app namespace
var app = app || {};
window.app = app;


/* Perform drawing operations */
function draw(time) {
	app.ctx.fillStyle = app.CLEAR_COLOR_FILL;
	app.ctx.fillRect(0, 0, app.canv.width, app.canv.height);
}


/* Update app state */
function update(time) {
}


/* Run this code when window is resized */
function resize() {
	app.canv.setAttribute('width', window.innerWidth);
	app.canv.setAttribute('height', window.innerHeight);
}


function init() {
	/**
	 *  Init canvas and add to app
	 */
	app.canv = document.body.appendChild(document.createElement('canvas'));
	app.canv.setAttribute('id', 'app-canvas');
	app.canv.setAttribute('width', window.innerWidth);
	app.canv.setAttribute('height', window.innerHeight);
	app.canv.style.setProperty('position', 'absolute');
	app.canv.style.setProperty('top', '0');
	app.canv.style.setProperty('left', '0');
	app.canv.style.setProperty('right', '0');
	app.canv.style.setProperty('bottom', '0');
	app.canv.style.setProperty('width', '100%');
	app.canv.style.setProperty('height', '100%');
	app.ctx = app.canv.getContext('2d');

	// Hook up resize function to window resize event
	window.addEventListener('resize', resize);

	/**
	 *  This is a good place to set app constants
	 */
	app.CLEAR_COLOR_FILL = '#1F0310';


	/**
	 *  Further initialization ... do your worst
	 */
}


init();
(function loop(time) {
	update(time);
	draw(time);
	window.requestAnimationFrame(loop);
})();
```

## Prerequisites

A Yeoman generator is essentially a Node.js module, so it it makes a lot of sense to have Node.js, npm, and Yeoman installed. Go install them!

``` bash
$ npm install -g yeoman
```


## Setting up

First of all, the Yeoman generator depends on some custom naming---if you want to call your generator `banana`, your root folder would be named `generator-banana`. I'll use my generator to create a loop-based code sketch, so I'm placing my files in a folder called `generator-loop-sketch`. You can read more about why at the Yeoman docs.

A Yeoman generator is a Node.js module, which means that it needs a `package.json` file describing the module. To create this file you either create it by hand, or run the command

``` bash
$ npm init
```

and follow the instructions. Make sure to add `yeoman-generator` as a dependency.

When you've created the `package.json` file you'll need to install the dependencies, i.e. `yeoman-generator`, with npm.

``` bash
$ npm install
```


## Creating the generator
When running the Yeoman generator it'll look for a few files that'll tell it what to do.

```
├─ package.json
├─ index.js
└─ templates/
   ├─ index.html
   └─ app.js
```

The file `index.js` in the root contains JavaScript that's executed every time the generator is run. The `templates` directory is where you place files to be copied. You can do more than copy files, including compiling templates, setting up configuration, and so on. You'll do this setup once in order to have Yeoman do it for your in the future, leaving you to focus on the fun stuff.

I want to copy the `index.html` and `app.js` files into each new loop sketch. I've created those files, with the contents described earlier in this article, and placed them in the `templates` folder.


## Making the generator do stuff

I want my generator to create a new folder and copy two files into that folder.

The basic Yeoman generator `index.js` extends the Yeoman `NamedBase` class and initiates itself by running the parent class' constructor.
``` javascript
// index.js

var generators = require('yeoman-generator');

module.exports = generators.NamedBase.extend({
	constructor: function() {
		generators.NamedBase.apply(this, arguments);
	}
});
```

To copy files I add the `writing` attribute, which shall contain a function that does writing operations. Yeoman will automatically run this function.

I want to place the `templates/index.html` and `templates/app.js` in a new folder structure, relative to where I run the Yeoman command.

```
└─ project-name/
   └─ app/
      ├─ index.html
      └─ js/
         └─ app.js
```

This is done with the `NamedBase.fs.copyTpl(templatePath, destinationPath, variables)`. Below I use `this.name` in the `writing()` function to access the name the user passed when running the Yeoman command.

``` javascript
// index.js

var generators = require('yeoman-generator');

module.exports = generators.NamedBase.extend({
	constructor: function() {
		generators.NamedBase.apply(this, arguments);
	},
	writing: function() {
		this.fs.copyTpl(
			this.templatePath('index.html'),
			this.destinationPath(this.name + '/app/index.html'),
			{}
		);

		this.fs.copyTpl(
			this.templatePath('app.js'),
			this.destinationPath(this.name + '/app/js/app.js'),
			{}
		);
	}
});
```

## Running the generator

Before running the generator we have to make sure that Yeoman knows about the generator. From the root of the generat, run

``` bash
$ npm link
```

to set everything up. When npm is done the generator is ready, and Yeoman is standing by waiting for the command.

``` bash
$ yo loop-sketch new-sketch
```

This will create a new folder named `new-sketch` containing the files mentioned earlier. Fresh and ready to be edited!


## Using templates

Just for the sake of it, we'll send the `name` variable to the `index.html` template and use it for its title tag.

``` javascript
// index.js
...
	writing: function() {
		this.fs.copyTpl(
			this.templatePath('index.html'),
			this.destinationPath(this.name + '/app/index.html'),
			{ title: this.name }  // Put this.name in the title attribute
		);
...
```
``` html
<!-- templates/index.html -->
...
<head>
	<!-- Yeoman replaces `<%= title %>` with whatever is in the `title` variable -->
	<title><%= title %></title>
...
```

## Where to next?

That's all. There's a lot of stuff you could add to your own generators, and the best place to learn about all that stuff is in the excellent [Yeoman documenation](http://yeoman.io/authoring/).

The source code for the generator in this article can be [found on Github](https://github.com/marcusstenbeck/generator-loop-sketch).