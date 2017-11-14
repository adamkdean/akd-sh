---
title: Pass Request buffer through Redis
slug: pass-request-buffer-through-redis
date: 2017-11-14 23:46
---

In a follow up to my [post last night](/post/pipe-stream-to-express), the following code takes an Express request, performs an external request, stores that response in a buffer which it then stores in Redis, which it then reads back, converts back into a buffer and sends that back to the Express response.

This doesn't store the headers or status code in Redis but it could easily be done.

This allows playback of a request/response cycle. Interesting concept really.

```
'use strict'

const express = require('express')
const request = require('request')
const streamBuffers = require('stream-buffers')
const through2 = require('through2')
const redis = require('redis')

const client = redis.createClient()
client.on('connect', () => { console.log('redis connected' )})
client.on('ready', () => { console.log('redis ready' )})
client.on('reconnecting', () => { console.log('redis reconnecting' )})
client.on('error', () => { console.log('redis error' )})
client.on('end', () => { console.log('redis end' )})

const app = express()
app.use('/', (incomingRequest, outgoingResponse) => {
  const outgoingRequest = request('http://via.placeholder.com/800x600?text=example')
  const randomKey = Math.random().toString(36).substr(2)
  const stream = new streamBuffers.WritableStreamBuffer()
  
  let _statusCode = null
  let _headers = null
  
  outgoingRequest.pipe(through2(function (chunk, enc, callback) {
    stream.write(chunk)
    callback()
  }))
  
  outgoingRequest.on('end', () => {
    const contents = stream.getContents()
    const base64 = contents.toString('base64')
    client.set(randomKey, base64)
    client.get(randomKey, (err, reply) => {
      const newBuffer = new Buffer(reply, 'base64')
      outgoingResponse.set(_headers).status(_statusCode)
      outgoingResponse.end(newBuffer)
      client.del(randomKey)
    })
  })
  
  outgoingRequest.on('response', (incomingResponse) => {
    _statusCode = incomingResponse.statusCode
    _headers = incomingResponse.headers
  })
})

app.listen(8000, () => {
  console.log('listening on 8000')
})
```
