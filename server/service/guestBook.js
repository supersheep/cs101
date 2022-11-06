const fs = require('fs')

if (!fs.existsSync('./data.json')) {
  fs.writeFileSync('./data.json', '{ "items": [] }')
}

module.exports = {
  loadPage(page) {
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

    return data
  },
  add() {
    const time = dayjs().format('YYYY-MM-DD HH:mm:ss')
    const json = JSON.parse(fs.readFileSync('./data.json'))
    const id = json.items.length + 1
    json.items.push({
      content: value,
      time,
      id
    })
    fs.writeFileSync('./data.json', JSON.stringify(json, null, 2))
  },
  delete(id) {
    const json = JSON.parse(fs.readFileSync('./data.json'))
    const itemIndex = json.items.findIndex(item => item.id === id)
    json.items.splice(itemIndex, 1)
    fs.writeFileSync('./data.json', JSON.stringify(json, null, 2))
  }
}