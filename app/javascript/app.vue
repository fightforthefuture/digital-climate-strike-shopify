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
                      label="If you would like to self-host the iFrame source code, you can configure the hostname for this here."></v-text-field>

                    <v-checkbox
                      v-model="disableGoogleAnalytics"
                      label="Removes Google Analytics tracking from the banner."></v-checkbox>

                    <v-checkbox
                      v-model="alwaysShowWidget"
                      label="Even if someone has closed the widget, this will make it show. Useful for testing purposes."></v-checkbox>

                    <v-checkbox
                      v-model="forceFullPageWidget"
                      label="Enforces the full page widget. Useful for testing."></v-checkbox>

                    <v-checkbox
                      v-model="showCloseButtonOnFullPageWidget"
                      label="Makes the full page banner closeable, in case your site is unable to do a complete shutdown on September 20."></v-checkbox>

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
                          label="Allows you to set the date when the footer banner should start showing. It defaults to an arbitrary date in the past."
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
                          label="Allows you to set the date when the full page banner should show."
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

                    If the user closes the banner, we set a cookie so they won't see it again on that device of this number of days.
                    <v-slider
                      v-model="cookieExpirationDays"
                      thumb-label="always"
                      :thumb-size="24"
                      :max="max"
                      :min="min"></v-slider>

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

      <v-snackbar
        v-model="snackbar"
        :bottom="true"
        :right="true"
        :timeout="3000"
        :vertical="true">
        {{ message }}
        <v-btn
          color="green darken-2"
          flat
          @click="snackbar = false">
          Close
        </v-btn>
      </v-snackbar>
    </v-content>
    <div class="loading-screen" v-show="loading">
      <div>
        <div class="loading-circle"></div>
      </div>
    </div>
  </v-app>
</template>

<script>
 import shopApi from 'api/shop'

 export default {
   mounted() {
     this.loading = true
     shopApi.get(
       (data) => {
         this.cookieExpirationDays = data.attributes.cookie_expiration_days
         this.disableGoogleAnalytics = data.attributes.disable_google_analytics
         this.alwaysShowWidget = data.attributes.always_show_widget
         this.forceFullPageWidget = data.attributes.force_full_page_widget
         this.showCloseButtonOnFullPageWidget = data.attributes.show_close_button_on_full_page_widget
         this.fullPageDisplayStartDate = data.attributes.full_page_display_start_date
         this.footerDisplayStartDate = data.attributes.footer_display_start_date
         this.iframeHost = data.attributes.iframe_host
         this.loading = false
       },
       (errors) => {
         this.message = "Couldn't load shop's widget params"
         this.snackbar = true
         this.loading = false
       }
     )
   },
   data: function () {
     return {
       loading: false,
       message: "",
       snackbar: false,
       max: 30,
       min: 1,
       cookieExpirationDays: 1,
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

   computed: {
     params() {
       return {
         shop: {
           cookie_expiration_days: this.cookieExpirationDays,
           disable_google_analytics: this.disableGoogleAnalytics,
           always_show_widget: this.alwaysShowWidget,
           force_full_page_widget: this.forceFullPageWidget,
           show_close_button_on_full_page_widget: this.showCloseButtonOnFullPageWidget,
           full_page_display_start_date: this.fullPageDisplayStartDate,
           footer_display_start_date: this.footerDisplayStartDate,
           iframe_host: this.iframeHost
         }
       }
     }
   },
   methods: {
     updateWidget() {
       this.loading = true
       shopApi.update(this.params,
                      (data) => {
                        this.message = "Widget Customization successfully updated"
                        this.snackbar = true
                        this.loading = false
                      },
                      (errors) => {
                        this.message = "Widget Customization unsuccessfully updated"
                        this.snackbar = true
                        this.loading = false
                      })
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
 .loading-screen {
   display: flex;
   align-items: center;
   justify-content: center;
   height: 100vh;
   width: 100vw;
   position: fixed;
   top: 0;
   left: 0;
   z-index: 300;
   flex-direction: column;
   user-select: none;
   background-color: rgba(0, 0, 0,0.392);
 }
 .loading-circle {
   width: 50px;
   height: 50px;
   border-radius: 100%;
   border: 2px solid transparent;
   border-left-color: green;
   animation: circleanimation .45s linear infinite
 }
 @keyframes circleanimation {
   from {
     transform: rotateZ(0deg);
   }
   to {
     transform: rotateZ(360deg);
   }
 }
</style>
