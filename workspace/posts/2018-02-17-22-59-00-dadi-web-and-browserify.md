---
title: DADI Web & Browserify
slug: dadi-web-and-browserify
date: 2018-02-17 22:59
---

Earlier tonight I wrote about [DADI Web &amp; SCSS](http://akd.sh/post/dadi-web-and-scss) using DADI Web middleware. Well, it gets even better. The following JavaScript preprocessor (based on [node-enchilada](https://github.com/defunctzombie/node-enchilada)) will serve up your JavaScript files all wrapped up using Browserify. That means you can use CommonJS and keep your client-side JavaScript tidy.

Again, all you need to do is drop this file into your `workspace/middleware` directory and make sure the paths are correct.

```js
const enchilada = require('enchilada')
const path = require('path')
const workdir = process.cwd()

const Middleware = function (app) {
  app.use(enchilada({
    src: path.join(workdir, 'workspace', 'public'),
    cache: process.env.NODE_ENV !== 'development',
    compress: process.env.NODE_ENV !== 'development'
  }))
}

module.exports = function (app) {
  return new Middleware(app)
}

module.exports.Middleware = Middleware
```

Protip: `enchilada` looks inside the `src` directory for a subsequent `js` directory. No need to specify `public/js` etc.

Learn more about [DADI Web](https://dadi.tech/en/web/).
