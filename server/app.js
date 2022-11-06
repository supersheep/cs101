const http = require('http')
const fs = require('fs')

// npm instal ejs
const ejs = require('ejs')
const dayjs = require('dayjs')

if (!fs.existsSync('./data.json')) {
  fs.writeFileSync('./data.json', '{ "items": [] }')
}

http.createServer(async(req, res) => {
  
  const [path, qs] = req.url.split('?')
  const query = {}
  if (qs) {
    qs.split('&').forEach(pair => {
      const [k, v] = pair.split('=')
      query[k] = v
    })
    if (query.p) {
      page = +query.p
    }
  }

  function render() {
    const template = fs.readFileSync('./views/index.ejs', 'utf-8')
    const json = JSON.parse(fs.readFileSync('./data.json'))
    let page = 1
    let pageSize = 5

    const allItems = [...json.items].reverse()
    const items = [...allItems].splice((page - 1) * pageSize, pageSize)
    const totalPages = Math.ceil(allItems.length / pageSize)

    const data = {
      items,
      totalPages,
      currentPage: page
    }
    const html = ejs.render(template, data)
    res.end(html)
  }

  let bodyStr = ''
  req.on('data', (data) => {
    bodyStr += data
  })
  req.on('end', () => {
    const [_, value] = bodyStr.split('=')

    if (path === '/delete') {
      const id = +query.id
      const json = JSON.parse(fs.readFileSync('./data.json'))
      const itemIndex = json.items.findIndex(item => item.id === id)
      json.items.splice(itemIndex, 1)
      fs.writeFileSync('./data.json', JSON.stringify(json, null, 2))
      res.writeHead(302, {
        'Location': '/'
      });
      res.end()
      return
    }

    if (req.method === 'POST') {
      const time = dayjs().format('YYYY-MM-DD HH:mm:ss')
      const json = JSON.parse(fs.readFileSync('./data.json'))
      const id = json.items.length + 1
      json.items.push({
        content: value,
        time,
        id
      })
      fs.writeFileSync('./data.json', JSON.stringify(json, null, 2))
    }

    render()
  })
}).listen(3000)