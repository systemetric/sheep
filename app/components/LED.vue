<template>
  <div class="led-container">
    <span class="led-large" :style="{ backgroundColor: colour }"></span>
    <span class="led-small" :style="{ backgroundColor: colour }"></span>
  </div>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  name: "led",
  props: {
    colour: {
      type: String,
      default: "#ff0000",
    },
  },
});
</script>

<style lang="scss">
@keyframes flash {
  from {
    transform: scale(0);
    opacity: 1;
  }
  to {
    transform: scale(1);
    opacity: 0;
  }
}

.led-container {
  position: relative;
  height: 30px;
  width: 30px;
}

.led-large {
  position: absolute;
  inset: 0;

  width: 30px;
  height: 30px;
  border-radius: 50%;

  animation: flash 1.5s ease-in-out infinite;
}

.led-small {
  position: absolute;
  inset: 8px;

  width: 14px;
  height: 14px;
  border-radius: 50%;
}
</style>
