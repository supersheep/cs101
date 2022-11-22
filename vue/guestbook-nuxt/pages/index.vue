<script>
import MessageItem from "../components/MessageItem.vue";
import PaginationFooter from "../components/PaginationFooter.vue";
import InputForm from "../components/InputForm.vue";

export default {
  components: {
    InputForm,
    PaginationFooter,
    MessageItem,
  },
  data() {
    const currentPage = this.$route.query.p || 1;
    console.log('current Page', currentPage)
    return {
      messages: [],
      currentPage: parseInt(currentPage),
      totalPages: 1,
    };
  },
  async fetch() {
    console.log('fetching!')
    await this.refresh(true)
  },
  // mounted() {
  //   this.refresh();
  // },
  methods: {
    async refresh(serverSide) {
      const resp = await fetch((serverSide ? 'http://127.0.0.1:8080' : '/api') + "/message?p=" + this.currentPage);
      const json = await resp.json();
      this.messages = json.items;
      this.totalPages = +json.totalPages;
      this.currentPage = +json.currentPage;
    },
    submit(text) {
      return fetch("/api/message/", {
        method: "POST",
        headers: {
          "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        },
        body: "text=" + text,
      }).then(() => {
        this.refresh();
      });
    },
    removeItem(item) {
      confirm("确定要删除#" + item.id + "么");
      fetch("/api/message/" + item.id, {
        method: "DELETE",
      }).then(() => {
        this.refresh();
      });
    },
  },
};
</script>

<template>
  <div class="main">
    <InputForm @submit="submit" />
    <div class="items">
      <MessageItem
        v-for="item in messages"
        :key="item.id"
        :item="item"
        @remove="removeItem"
      />
    </div>
    <PaginationFooter :total-pages="totalPages" :current-page="currentPage" />
  </div>
</template>

<style>
body {
  --color-text-black: #3d3d3d;
  --color-green: #3aa253;

  font-family: sans-serif;
  margin: 0;
  background-color: #e8e8e8;
}

.main {
  box-sizing: border-box;
  padding: 30px;
  width: 600px;
  margin: 0 auto;
  background: #fff;
}
</style>
