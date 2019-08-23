<template>
  <v-app id="inspire">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 md4>
            <v-img src="/strike-logo-EN-color.png" aspect-ratio="1.618" contain />
          </v-flex>

          <v-flex xs12 md6>
            <v-container fill-height fluid>
              <v-layout fill-height>
                <v-flex xs12 align-end flexbox>
                  <span class="display-1">Widget Customization</span>
                </v-flex>
              </v-layout>
            </v-container>

            <v-container fill-height fluid>
              <v-layout fill-height>
                <v-flex xs12 align-end flexbox>
                  <form>
                    <v-text-field
                      v-model="iframeHost"
                      required
                      :rules="iframeHostRules"
                      label="Override the iFrame hostname"></v-text-field>

                    <v-checkbox
                      v-model="disableGoogleAnalytics"
                      label="Disable Google Analytics"></v-checkbox>

                    <v-checkbox
                      v-model="alwaysShowWidget"
                      label="Always show Widget"></v-checkbox>

                    <v-checkbox
                      v-model="forceFullPageWidget"
                      label="Force full page Widget"></v-checkbox>

                    <v-checkbox
                      v-model="showCloseButtonOnFullPageWidget"
                      label="Show close button on full page"></v-checkbox>
                    <v-layout wrap justify-space-between>
                      <v-flex xs12 md6>
                        <v-dialog
                          ref="dialogFooterDisplayStartDate"
                          v-model="modalFooterDisplayStartDate"
                          :return-value.sync="footerDisplayStartDate"
                          persistent
                          lazy
                          full-width
                          width="290px">
                          <template v-slot:activator="{ on }">
                            <v-text-field
                              v-model="footerDisplayStartDate"
                              label="The date when the sticky footer widget should start showing"
                              prepend-icon="event"
                              readonly
                              v-on="on"></v-text-field>
                          </template>
                          <v-date-picker v-model="footerDisplayStartDate" scrollable>
                            <v-spacer></v-spacer>
                            <v-btn flat color="primary" @click="modalFooterDisplayStartDate = false">Cancel</v-btn>
                            <v-btn flat color="primary" @click="$refs.dialogFooterDisplayStartDate.save(footerDisplayStartDate)">OK</v-btn>
                          </v-date-picker>
                        </v-dialog>
                      </v-flex>

                      <v-flex xs12 md6>
                        <v-dialog
                          ref="dialogFullPageDisplayStartDate"
                          v-model="modalFullPageDisplayStartDate"
                          :return-value.sync="fullPageDisplayStartDate"
                          persistent
                          lazy
                          full-width
                          width="290px">
                          <template v-slot:activator="{ on }">
                            <v-text-field
                              v-model="fullPageDisplayStartDate"
                              label="The date when the full page widget should show for 24 hours"
                              prepend-icon="event"
                              readonly
                              v-on="on"></v-text-field>
                          </template>
                          <v-date-picker v-model="fullPageDisplayStartDate" scrollable>
                            <v-spacer></v-spacer>
                            <v-btn flat color="primary" @click="modalFullPageDisplayStartDate = false">Cancel</v-btn>
                            <v-btn flat color="primary" @click="$refs.dialogFullPageDisplayStartDate.save(fullPageDisplayStartDate)">OK</v-btn>
                          </v-date-picker>
                        </v-dialog>
                      </v-flex>

                      <v-slider
                        v-model="maxcookieExpirationDays"
                        thumb-label="always"
                        :max="max"
                        :min="min"
                        label="Cookie expiration days"></v-slider>
                    </v-layout>

                    <v-btn @click="updateWidget" color="success">
                      Update
                    </v-btn>
                  </form>
                </v-flex>
              </v-layout>
            </v-container>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
 export default {
   data: function () {
     return {
       max: 30,
       min: 1,
       maxcookieExpirationDays: 1,
       disableGoogleAnalytics: false,
       alwaysShowWidget: false,
       forceFullPageWidget: false,
       showCloseButtonOnFullPageWidget: false,
       fullPageDisplayStartDate: new Date(2019, 8, 20).toISOString().substr(0, 10),
       footerDisplayStartDate: new Date().toISOString().substr(0, 10),
       iframeHost: 'https://assets.digitalclimatestrike.net',
       modalFullPageDisplayStartDate: false,
       modalFooterDisplayStartDate: false,
       iframeHostRules: [
         v => !!v || 'Name is required',
       ],
     }
   },

   methods: {
     updateWidget() {
     }
   }
 }
</script>

<style scoped>
 p {
   font-size: 2em;
   text-align: center;
 }
 .v-input--slider {
   margin-top: 24px;
 }
</style>
