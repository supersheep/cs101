<script>
export default {
  data() {
    return {
      text: "",
    };
  },
  methods: {
    submit() {
      this.$emit("submit", this.text);
    },
  },
};
</script>
<template>
  <div class="form">
    <textarea placeholder="写点啥..." v-model="text" name="text"></textarea>
    <button type="submit" @click="submit">提交</button>
  </div>
</template>
<style lang="less">
.form {
  text-align: right;
  textarea {
    resize: none;
    font-size: 18px;
    padding: 10px;
    width: 100%;
    box-sizing: border-box;
    display: block;
    height: 77px;
    border: 0;
    box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.2);
    border-radius: 5px;
  }
  button {
    margin-top: 25px;
    width: 90px;
    height: 40px;
    border-radius: 5px;
    border: 0;
    font-size: 18px;
    color: #fff;
    background-color: var(--color-green);
  }
}
</style>
