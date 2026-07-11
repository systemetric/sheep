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

      <fieldset>
        <legend>Misc</legend>
        <input
          type="file"
          ref="imageFile"
          accept=".jpg"
          style="display: none"
          @change="imageUpload"
        />
        <button @click="uploadTeamLogo">Upload Team Logo</button>
        <input
          type="file"
          ref="patchFile"
          accept=".zip"
          style="display: none"
          @change="patchUpload"
        />
        <button @click="uploadPatch">Upload Patch</button>
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
  ACTION_UPLOAD_PATCH,
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
  methods: {
    submitAndClose() {
      this.$store.commit(MUTATION_SET_RUN_CONFIG, {
        zone: this.zone,
        mode: this.mode,
      } as RunConfiguration);
      this.$emit("close");
    },
    imageUpload() {
      const team_logo_file = (this.$refs as any).imageFile.files[0];
      if (!team_logo_file) return;

      console.log(`Uploading team image ${team_logo_file.name}...`);

      this.$store.dispatch(ACTION_UPLOAD_TEAM_LOGO, team_logo_file);
      this.$emit("close");
    },
    patchUpload() {
      const patch_file = (this.$refs as any).patchFile.files[0];
      if (!patch_file) return;

      console.log(`Uploading patch ${patch_file.name}...`);

      this.$store.dispatch(ACTION_UPLOAD_PATCH, patch_file);
      this.$emit("close");
    },
    uploadTeamLogo() {
      (this.$refs as any).imageFile.click();
    },
    uploadPatch() {
      (this.$refs as any).patchFile.click();
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
}
</style>
