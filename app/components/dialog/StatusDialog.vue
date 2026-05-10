<template>
  <DialogWrapper width="fit-content" maxWidth="600px">
    <template slot="title">Service Status</template>
    <div>
      <table>
        <tr v-for="(status, service) in statuses" :key="service">
          <td
            :class="[
              `status-${status}`,
              { required: expected.includes(service) },
            ]"
          >
            {{ service }}
          </td>
          <td
            :class="[
              `status-${status}`,
              { required: expected.includes(service) },
            ]"
          >
            {{ status }}
          </td>
          <td>{{ notes[service] || "" }}</td>
        </tr>
      </table>
    </div>
    <template slot="actions">
      <button @click="$emit('close')">Close</button>
    </template>
  </DialogWrapper>
</template>

<script lang="ts">
import Vue from "vue";
import { EXPECTED_SERVICES, SERVICE_NOTES } from "@/store";

export default Vue.extend({
  name: "status-dialog",
  computed: {
    notes() {
      return SERVICE_NOTES;
    },
    expected() {
      return EXPECTED_SERVICES;
    },
    statusColour() {
      return this.$store.state.status.statusColour;
    },
    statuses() {
      return this.$store.state.status.statuses;
    },
  },
});
</script>

<style lang="scss">
table,
tr,
td {
  border: 1px solid #888;
  padding: 5px;
}

table {
  border-collapse: collapse;
}

.status-online {
  color: #0b0;
}

.status-offline {
  color: #ff8c00;

  &.required {
    color: #ff2500;
  }
}
</style>
