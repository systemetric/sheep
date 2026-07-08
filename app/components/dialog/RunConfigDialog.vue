<template>
  <DialogWrapper>
    <template slot="title">Options</template>
    <div>
      <fieldset style="margin-bottom: 1em">
        <legend>Zone</legend>
        <label v-for="color in zones">
          <input type="radio" :value="color" v-model="zone" />
          {{ color }}
        </label>
      </fieldset>

      <fieldset style="margin-bottom: 1em">
        <legend>Mode</legend>
        <label>
          <input type="radio" value="dev" v-model="mode" />
          Development
        </label>
        <label>
          <input type="radio" value="comp" v-model="mode" />
          Competition
        </label>
      </fieldset>

      <fieldset style="margin-bottom: 1em">
        <legend>Misc</legend>
        <input
          type="file"
          ref="file"
          accept=".jpg"
          style="display: none"
          @change="imageChanged"
        />
        <button @click="uploadTeamLogo">Upload Team Logo</button>
      </fieldset>

      <hr style="margin-bottom: 1em" />

      <p style="margin-bottom: 1em">
        The following options only affect the <b>current project</b>
      </p>

      <fieldset :class="{ disabled: !hasProject }">
        <legend>Attributes</legend>
        <div>
          <table>
            <tr style="font-weight: bold">
              <td>Key</td>
              <td>Value</td>
            </tr>
            <tr v-for="[key, val] of meta" :key="key">
              <td>
                {{ key }}
              </td>
              <td>
                {{ val }}
              </td>
            </tr>
          </table>
        </div>
      </fieldset>
    </div>
    <template slot="actions">
      <button @click="submitAndClose">Close</button>
    </template>
  </DialogWrapper>
</template>

<script lang="ts">
import Vue from "vue";
import {
  MUTATION_SET_RUN_CONFIG,
  RunConfiguration,
  ACTION_UPLOAD_TEAM_LOGO,
} from "@/store";

export default Vue.extend({
  name: "run-config-dialog",
  data() {
    return {
      zone:
        this.$store.state.runConfig.zone !== undefined
          ? this.$store.state.runConfig.zone
          : "red",
      mode:
        this.$store.state.runConfig.mode !== undefined
          ? this.$store.state.runConfig.mode
          : "dev",
      zones: ["red", "yellow", "green", "blue"],
    };
  },
  computed: {
    hasProject() {
      return this.$store.state.currentProject !== undefined;
    },
    meta() {
      return this.$store.state.currentProject === undefined
        ? []
        : Object.entries(this.$store.state.currentProject.meta).filter(
            (m) => m[0] !== "project_name",
          );
    },
  },
  methods: {
    submitAndClose() {
      this.$store.commit(MUTATION_SET_RUN_CONFIG, {
        zone: this.zone,
        mode: this.mode,
      } as RunConfiguration);
      this.$emit("close");
    },
    imageChanged() {
      const team_logo_file = (this.$refs as any).file.files[0];
      if (!team_logo_file) return;

      console.log(`Uploading ${team_logo_file.name}...`);

      this.$store.dispatch(ACTION_UPLOAD_TEAM_LOGO, team_logo_file);
    },
    uploadTeamLogo() {
      (this.$refs as any).file.click();
    },
  },
});
</script>

<style lang="scss">
fieldset {
  border-color: #aaa;
  border-width: 1px;
  border-style: solid;

  padding: 0.5em;

  legend {
    padding: 0 0.25em;
  }

  table,
  tr,
  td {
    border: 1px solid #aaa;
    padding: 5px;
  }

  tr:nth-child(odd) {
    background-color: #222;
  }

  tr:nth-child(even) {
    background-color: #333;
  }

  table {
    border-collapse: collapse;
    width: 100%;
  }
}

fieldset.disabled {
  border-color: #666;
  color: #666;

  table,
  tr,
  td {
    border: 1px solid #666;
  }
}
</style>
