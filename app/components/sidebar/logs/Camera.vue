<template>
  <div id="camera-preview">
      <img v-bind:src="imageSrc">
  </div>
</template>

<script lang="ts">
import { makeFullUrl } from '@/store';

function connectSocket() {
  const ws = new WebSocket("ws://"+window.location.hostname+":5001/");
  console.log("Connecting to websocket at "+window.location.hostname+":5001");
  ws.onopen = function () {
    console.log("Connected to websocket.");
  }
  ws.onclose = function() {
    console.log("Websocket disconnected, trying to reconnect...");
    setTimeout(function() {
      connectSocket();
    }, 1000);
}
export default {
  data() {
    return {
      imageSrc: makeFullUrl("/static/image.jpg"),
    };
  },
  mounted() {

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
