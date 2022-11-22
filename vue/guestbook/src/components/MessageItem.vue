<script>
export default {
  emits: ["remove"],
  props: {
    item: Object,
  },
  methods: {
    remove() {
      this.$emit("remove", this.item);
    },
  },
};
</script>
<template>
  <div class="item">
    <div class="content">
      {{ item.content }}
    </div>
    <div class="footer">
      <div class="time">
        {{ item.time }}
      </div>
      <div class="remove" @click="remove">删除</div>
    </div>
  </div>
</template>
<style lang="less">
.item {
  margin-top: 25px;
  .item .footer {
    font-size: 14px;
    color: #666;
    margin-top: 10px;
  }
  .footer {
    display: flex;
    justify-content: space-between;
    .remove {
      cursor: pointer;
    }
  }
}
</style>
