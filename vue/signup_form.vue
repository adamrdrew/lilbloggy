<component name="signup_form">
<template lang="slim">
.col-md-4.offset-md-4
    .card.lb-post.w-100.mb-3 v-if="signup_enabled"
        .card-header
            h4.card-title.lb-title Sign Up
        .card-body
            .form-group
                label User Name
                input.form-control v-model="name" v-on:keyup="check_name" type="text" placeholder="cool_user_1982"
                .alert.alert-danger v-if="name_is_taken" 
                    | Sorry, that name is taken.
                .alert.alert-success v-if="show_good_name_message"
                    | That name looks good!
                .alert.alert-danger v-if="!name_is_valid && name.length > 0" 
                    | No spaces or weird charecters please.
            .form-group
                label Password
                input.form-control v-model="password" v-on:keyup="validate_pass" type="password"
                div.alert.alert-danger v-if="!pw_is_valid" 
                    | Weak password. You can do better
            .form-group
                label Verify Password
                input.form-control v-model="pw_confirm" type="password" @keyup.enter="submit"
                div.alert.alert-danger v-if="!pw_match"
                    | Passwords do not match
            button.btn.btn-success v-on:click="submit" v-bind:disabled="can_submit" Sign Up
    .card.lb-post.w-100.mb-3 v-if="!signup_enabled"
        .card-header
            h4.card-title.lb-title Sign Up Disabled!
        .card-body
            | Oops! New account creation is disabled for this blog. Please contact the site administrator or edit the Lil Bloggy app config file.
</template>

<script>
    data: function() {
        return {    name_is_taken: false,
                    name_is_valid: false,
                    pw_is_valid: false,
                    name: "",
                    password: "",
                    pw_confirm: "",
                    salt: "",
                    hash: ""
                }
    },
    methods: {
        check_name: function() {
            if (this.name.length == 0 ) {
                this.name_is_valid = false;
                return;
            }
            XHR({
                method: 'POST',
                url: '/user/check_name',
                data: JSON.stringify({name: this.name}),
            }).success(function (data) {
                    this.name_is_taken = data.taken;
                    this.name_is_valid = ! /[^a-zA-Z0-9\-\\_\/]/.test(this.name);
            }.bind(this));
        },
        validate_pass: function() {
            if (this.password.length < 8 ) {
                this.pw_is_valid = false;
                return
            };
            this.pw_is_valid = true;
        },
        submit: function() {
            var payload = this.signup_payload;
            XHR({
                method: 'POST',
                url: '/user/signup',
                data: JSON.stringify(payload),
            }).success(function (data) {
                console.log("success");
                this.$dispatch('login', true);
                this.$route.router.go('profile');
                return;
            }.bind(this)).error(function(data){
                console.log("fail");
                alert('Something went wrong signing up :(');
                return;                
            });                  
        }
    },
    computed: {
        can_submit:  function() {
            if (!this.name_is_taken && this.name_is_valid && this.pw_is_valid && this.pw_match) {
                return false;
            } 
            return true;
        },
        signup_payload: function() {
            this.salt =  Math.floor(Date.now());
            var hasher = new jsSHA("SHA-512", "TEXT");
            hasher.update(this.password+this.salt);
            this.hash = hasher.getHash("HEX");
            return {name: this.name, salt: this.salt, hash: this.hash};
        },
        pw_match: function() {
            if (this.password == this.pw_confirm) return true;
            return false;
        },
        signup_enabled: function() {
            return this.$store.getters.signup_enabled;
        },
        show_good_name_message: function() {
            return (!this.name_is_taken && this.name_is_valid && this.name.length > 0)
        }
    }
</script>
</component>
