<template>
  <div class="status" @click="openStatus">
    <LED class="led" :colour="statusColour" />
    <span>Status</span>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { StatusSummary, MUTATION_SET_STATUS_OPEN } from "@/store";
import LED from "@/components/LED.vue";

export default Vue.extend({
  name: "status",
  computed: {
    statusColour() {
      return this.$store.state.status.statusColour;
    },
  },
  methods: {
    openStatus() {
      this.$store.commit(MUTATION_SET_STATUS_OPEN, true);
    },
  },
});
</script>

<style lang="scss">
.status {
  height: 35px;
  padding: 0 0 0 5px;
  font-size: 13px;

  display: flex;
  align-items: center;

  user-select: none;

  span {
    flex-grow: 1;
    padding-left: 5px;
  }

  &:hover {
    background-color: rgba(255, 255, 255, 0.1);
  }

  &.disabled {
    pointer-events: none;
    cursor: not-allowed;
    background-color: transparent;
  }
}

.led {
  display: inline-block;
}
</style>
