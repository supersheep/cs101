<script>
import MessageItem from "./components/MessageItem.vue";
import PaginationFooter from "./components/PaginationFooter.vue";
import InputForm from "./components/InputForm.vue";

export default {
  components: {
    InputForm,
    PaginationFooter,
    MessageItem,
  },
  data() {
    const currentPage = new URL(location.href).searchParams.get("p") || 1;
    return {
      messages: [],
      currentPage: parseInt(currentPage),
      totalPages: 1,
    };
  },
  mounted() {
    this.refresh();
  },
  methods: {
    async refresh() {
      const resp = await fetch("/api/message?p=" + this.currentPage);
      const json = await resp.json();
      this.messages = json.items;
      this.totalPages = +json.totalPages;
      this.currentPage = +json.currentPage;
    },
    submit(text) {
      return fetch("/api/message/", {
        method: "POST",
        body: "text=" + text,
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
      <MessageItem v-for="item in messages" :key="item.id" :item="item" />
    </div>
    <PaginationFooter :totalPages="totalPages" :currentPage="currentPage" />
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
  background: #ffffff;
}
</style>
