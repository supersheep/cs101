<script>
export default {
  props: {
    totalPages: Number,
    currentPage: Number,
  },
  computed: {
    pages() {
      const pages = [];
      let page = 1;
      while (page <= this.totalPages) {
        pages.push(page);
        page += 1;
      }
      return pages;
    },
  },
};
</script>
<template>
  <div class="pagination">
    <template v-for="page in pages" :key="page">
      <span v-if="currentPage == page" class="page current">{{ page }}</span>
      <a v-else class="page" :href="'/?p=' + page">{{ page }}</a>
    </template>
  </div>
</template>
<style lang="less">
.pagination {
  display: flex;
  justify-content: flex-end;
  .page {
    width: 21px;
    height: 23px;
    font-size: 12px;
    line-height: 23px;
    margin-left: 10px;
    color: var(--color-text-black);
    text-decoration: none;
    text-align: center;
    cursor: pointer;
    &:hover {
      color: var(--color-green);
    }
    &.current {
      background-color: var(--color-green);
      color: #fff;
      cursor: default;
    }
  }
}
</style>
