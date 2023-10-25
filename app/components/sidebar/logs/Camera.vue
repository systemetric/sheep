<template>
  <div id="camera-preview">
      <img v-bind:src="imageSrc">
  </div>
</template>

<script lang="ts">
const ws = new WebSocket("ws://robot.local:5001/");
export default {
  data() {
    return {
      imageSrc: "/static/image.jpg",
    };
  },
  mounted() {
    // Assuming you have a WebSocket instance named "ws"
    ws.onmessage = ({ data }) => {
      this.imageSrc = "data:image/png;base64,"+data;
      console.log("Updated image");
    };
  },
};
</script>
<style lang="scss">
@import "../../../variables";

//noinspection CssOptimizeSimilarProperties
#camera-preview {
  width: 100%;
  height: $sidebar-width * 0.5625;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}
</style>
