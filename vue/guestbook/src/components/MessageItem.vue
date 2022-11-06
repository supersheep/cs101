<script>
export default {
  props: {
    item: Object,
  },
};
</script>
<template>
  <div class="item">
    <div class="content">
      {{ item.content }}
    </div>
    <div class="footer">{{ item.time }}</div>
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
}
</style>
