<template>
    <DialogWrapper>
        <template slot="title">Run Options</template>
        <div>
            <fieldset style="margin-bottom: 1em;">
                <legend>Zone</legend>
                <label v-for="n in 4" :key="n">
                    <input type="radio" :value="n - 1" v-model="zone" />
                    {{ n - 1 }}
                </label>
            </fieldset>

            <fieldset>
                <legend>Mode</legend>
                <label>
                    <input type="radio" value="development" v-model="mode" />
                    Development
                </label>
                <label>
                    <input type="radio" value="competition" v-model="mode" />
                    Competition
                </label>
            </fieldset>
        </div>
        <template slot="actions">
            <button @click="submitAndClose">Close</button>
        </template>
    </DialogWrapper>
</template>

<script lang="ts">
import Vue from "vue";
import { MUTATION_SET_RUN_CONFIG, RunConfiguration } from "@/store";

export default Vue.extend({
  name: "run-config-dialog",
  data() {
    return {
        zone: this.$store.state.runConfig.zone !== undefined ? this.$store.state.runConfig.zone : 0,
        mode: this.$store.state.runConfig.mode !== undefined ? this.$store.state.runConfig.mode : 'development'
    }
  },
  methods: {
    submitAndClose() {
        this.$store.commit(MUTATION_SET_RUN_CONFIG, { zone: this.zone, mode: this.mode } as RunConfiguration);
        this.$emit('close');
    }
  }
});
</script>

<style lang="scss">
fieldset {
    border-color: #aaa;
    border-width: 2px;

    padding: 0.5em;

    legend {
        padding: 0 0.25em;
    }
}
</style>
