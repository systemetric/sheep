<template>
  <div id="camera-preview">
      <img :src="url + '?rnd=' + cacheKey">
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { makeFullUrl } from "../../../store";

var rnd = 0;
//which IP should I use instead of localhost..?
const cameraSocket = new WebSocket("ws://robot.go:5001");//connects to websocket in shepherd websocks.py
// Connection opened
cameraSocket.addEventListener("open", (event) => {
  console.log("Connected to camera websocket.")//acknowledge connection to the websocket
});

/*
// Listen for messages
cameraSocket.addEventListener("message", (event) => {
  if (event.data == 'Camera updated') {
    rnd++;
    console.log("Camera updated.");
    export default {data() { return {newimgurl: imgurl + rnd}}};
  }
});
*/

export default {

  name: 'Images',
  data () {
    return {
      url: makeFullUrl("/static/image.jpg"),
      cacheKey: rnd,
    }
  },

  mounted: function () {
    cameraSocket.addEventListener("message", (event) => {//upon message received
      if (event.data == 'Camera updated') {
        rnd++;//change ?rnd= attribute of url to trick browsers into reloading the image
        console.log("Camera updated.");
      }
    });
    },

  destroyed() {//on websocket disconnected
    cameraSocket.close();
  },

}
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
