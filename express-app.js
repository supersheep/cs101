const express = require('express')
const bodyParser = require('body-parser')
const guestBookService = require('./service/guestBook')
const app = express()
const qs = require('qs')

app.use(bodyParser.urlencoded({ extended: true }))
app.set('view engine', 'ejs')

function renderPage(req, res) {
  const page = req.query.p
  const items = guestBookService.loadPage(page)
  const totalPages = guestBookService.totalPages()

  res.render('index', {
    currentPage: page,
    totalPages,
    items
  })
}

app.get('/', renderPage)

app.post('/', (req, res) => {
  console.log('req', req.body)
  renderPage(req, res)
})

app.listen(3000)