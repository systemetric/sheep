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
              <td></td>
            </tr>
            <tr v-for="[key, val] of meta" :key="key">
              <td>
                {{ key }}
              </td>
              <td>
                {{ val }}
              </td>
              <td>
                <button @click="deleteKey(key)">Delete</button>
              </td>
            </tr>
            <tr>
              <td>
                <input
                  type="text"
                  v-model="add_key"
                  placeholder="Key"
                  :disabled="!hasProject"
                />
              </td>
              <td>
                <input
                  type="text"
                  v-model="add_value"
                  placeholder="Value"
                  :disabled="!hasProject"
                />
              </td>
              <td>
                <button @click="addKey" :disabled="!hasProject">Add</button>
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
  ACTION_SAVE_PROJECT,
  MUTATION_MARK_PROJECT_SAVED,
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
      add_key: "",
      add_value: "",
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
      this.add_key = "";
      this.add_value = "";
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
    deleteKey(key) {
      if (this.$store.state.currentProject) {
        Vue.delete(this.$store.state.currentProject.meta, key);
        this.$store.dispatch(ACTION_SAVE_PROJECT, null);
      }
    },
    addKey() {
      this.add_key = this.add_key.trim();
      this.add_value = this.add_value.trim();

      if (
        this.add_key == "" ||
        this.add_value == "" ||
        this.add_key.includes(":") ||
        this.add_value.includes(":")
      ) {
        console.error(
          `invalid value for (key,value) = (${this.add_key},${this.add_value})`,
        );
        return;
      }

      if (this.$store.state.currentProject) {
        if (this.add_key in this.$store.state.currentProject.meta) {
          this.$store.state.currentProject.meta = Object.assign(
            {},
            this.$store.state.currentProject.meta,
            { [this.add_key]: this.add_value },
          );
        } else {
          Vue.set(
            this.$store.state.currentProject.meta,
            this.add_key,
            this.add_value,
          );
        }
        this.$store.dispatch(ACTION_SAVE_PROJECT, null);
      }

      this.add_key = "";
      this.add_value = "";
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
