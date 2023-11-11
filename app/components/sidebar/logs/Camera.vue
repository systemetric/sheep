<template>
  <div id="camera-preview">
      <img v-bind:src="imageSrc">
  </div>
</template>

<script lang="ts">
import { makeFullUrl } from '@/store';

export default {
  data() {
    return {
      imageSrc: makeFullUrl("/static/image.jpg"),
      socket: null,
      socketUrl: "ws://"+window.location.hostname+":5001/",
      reconnectInterval: 2000,
    };
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
        if (data.substring(0,8) == "[CAMERA]") {
          this.imageSrc = "data:image/png;base64,"+data.substring(8);
          console.log("Image updated");
        }
      };
      this.socket.onclose = (event) => {
        console.log(
          `WebSocket connection closed with code ${event.code}. Reconnecting in ${this.reconnectInterval}ms...`
        );
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
  height: min-content;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
}
</style>
