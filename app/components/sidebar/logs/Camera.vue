<template>
  <div id="camera-preview">
      <img v-bind:src="imageSrc">
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { mapState } from "vuex";

export default Vue.extend({
  name: "camera-preview",
  computed: mapState(["imageSrc"])
});

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
