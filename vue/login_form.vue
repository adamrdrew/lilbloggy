<component name="login_form">
<template lang="slim">
.col-md-4.offset-md-4
    .card.lb-post.w-100.mb-3
        .card-header
            h4.card-title.lb-title Log In
        .card-body
            .form-group
                label User Name
                input.form-control placeholder="cool_user_1982" type="text" v-model="name"
                .alert.alert-danger v-if="!name_is_valid"  That is not a valid username.
            .form-group
                label Password
                input.form-control v-model="password" @keyup.enter="submit"  type="password"
            button.btn.btn-success.pull-right v-bind:disabled="!can_submit" v-on:click="submit"  Log In
</template>

<script>
    data: function() {
        return {
            name: "",
            password: "",
            salt: "",
            hash: "",
            uuid: ""
        }
    },
    methods: {
        login_error: function() {
            alert('Username or password not recognized');
        },
        submit: function() {
            this.get_salt_and_uuid();
        },
        get_salt_and_uuid: function() {
            XHR({
                method: 'POST',
                url: "/user/auth/handshake",
                data: JSON.stringify({name: this.name})
            }).success(function (data) {
                this.salt = data.salt;
                this.perform_auth();
            }.bind(this)).error(function(e){
                this.login_error();
            }.bind(this));
        },
        perform_auth: function() {
            var auth_payload = this.auth_payload;
            XHR({
                method: 'POST',
                url: "/user/auth",
                data: JSON.stringify(auth_payload)
            }).success(function (data) {
                this.uuid = data.uuid;
            }.bind(this)).error(function(data){
                this.login_error();
            }.bind(this));          
        }
    },
    computed: {
        name_is_valid: function() {
            return !/[^a-zA-Z0-9\-\\_\/]/.test(this.name);
        },
        pw_is_valid: function() {
            if (this.password.length < 8 ) {
                return false;
            };
            return true;
        },
        can_submit: function() {
            if (this.name_is_valid && this.pw_is_valid) return true;
            return false;
        },
        auth_payload: function() {
            var hasher = new jsSHA("SHA-512", "TEXT");
            hasher.update(this.password+this.salt);
            this.hash = hasher.getHash("HEX");
            return {name: this.name, hash: this.hash};
        }

    }
</script>

<style>
.adam {
    color: red;
}
</style>

</component>