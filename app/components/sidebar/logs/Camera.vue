<template>
  <div id="camera-preview">
      <img :src="url + '?rnd=' + cacheKey">
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { makeFullUrl } from '@/store';

connectSocket();

export default {

  name: 'Images',
  data () {
    return {
      url: makeFullUrl("/static/image.jpg"),
      cacheKey: +new Date(),
    }
  },
  created() {
    this.connectToWebSocket();
  },
  methods: {
    connectToWebSocket() {
      this.socket = new WebSocket(this.socketUrl);
      this.socket.onopen = () => {
        console.log("WebSocket connection established");
      };
      this.socket.onmessage = ({ data }) => {
        this.imageSrc = "data:image/png;base64,"+data;
        console.log("Image updated");
      };
      this.socket.onclose = (event) => {
        console.log(
          `WebSocket connection closed with code ${event.code}. Reconnecting in ${this.reconnectInterval}ms...`
        );
        this.imageSrc = makeFullUrl("/static/reconnecting.jpg");
        setTimeout(() => {
          this.connectToWebSocket();
        }, this.reconnectInterval);
      };
    },
  },
};

</script>

<style lang="scss">
@import "../../../variables";

//noinspection CssOptimizeSimilarProperties
#camera-preview {
  width: 100%;
  height: $sidebar-width * 0.75;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}
</style>