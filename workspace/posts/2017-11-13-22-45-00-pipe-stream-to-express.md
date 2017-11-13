---
title: Pipe Stream to Express
slug: pipe-stream-to-express
date: 2017-11-13 23:45
---

As part of a project I'm working on, I need to grab some data via HTTP/S and transmit it as binary, but with access to it's headers. The following is a quick proof of concept to listen for HTTP requests with Express, request an external image on request, and pipe the response back through to the Express response socket while having access to response metadata such as headers.

```
'use strict'

const express = require('express')
const request = require('request')
const through2 = require('through2')

const app = express()
const imageUrl = 'http://via.placeholder.com/800x600?text=example'

app.use((incomingRequest, outgoingResponse) => {
  const outgoingRequest = request(imageUrl)
  const bufferOnPipe = through2(function (chunk, enc, callback) {
    this.push(chunk)
    callback()
  })
  const bufferedResponse = outgoingRequest.pipe(bufferOnPipe)
  
  outgoingRequest.on('response', (incomingResponse) => {
    if (incomingResponse.statusCode === 200) {
      console.log('statusCode:', incomingResponse.statusCode)
      console.log('headers:', incomingResponse.headers)
      bufferedResponse.pipe(outgoingResponse)
    } else {
      console.log('non-200 statusCode:', incomingResponse.statusCode)
    }
  })
})

app.listen(8000, () => {
  console.log('listening on 8000')
})
```
