const express = require('express')
const bodyParser = require('body-parser')
const guestBookService = require('./service/guestBook')
const app = express()

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.get('/message', (req, res) => {
  const page = req.query.p
  const pageModel = guestBookService.loadPage(page)
  res.send(pageModel)
})

app.post('/message', (req, res) => {
  const { content } = req.body
  const id = guestBookService.add(content)
  res.send({
    id,
    success: true
  })
})

app.delete('/message/:id', (req, res) => {
  const { id } = req.params
  guestBookService.delete(id)
  res.send({
    success: true
  })
})

app.listen(8080)
console.log('server started at http://localhost:8080')