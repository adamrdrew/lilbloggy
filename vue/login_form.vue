<component name="login_form">
<template lang="slim">
.col-md-4.col-md-offset-4
    .panel.panel-default
        .panel-heading.panel-heading-pink
            h3.panel-title Log In
        .panel-body
            .form-group
                label User Name
                input.form-control placeholder="cool_user_1982" type="text" v-model="name" v-on:keyup="validate_name"
                .alert.alert-danger v-if="!name_is_valid"  That\'s not a valid username.
            .form-group
                label Password
                input v-model="password" @keyup.enter="submit" v-on:keyup="validate_pass" type="password" class="form-control"
        .panel-footer.clearfix
            button.btn.btn-success.pull-right v-bind:disabled="!can_submit" v-on:click="submit"  Log In
</template>

<script>
    data: function() {
        return {name: "",
                password: "",
                salt: "",
                hash: "",
                uuid: ""
                }
    },
    methods: {
        submit: function() {
            if (!this.can_submit) return;
            this.can_submit = false;
            this.get_salt_and_uuid();

        },
        get_salt_and_uuid: function() {
            $.ajax({
                method: 'POST',
                url: '/api/auth_handshake',
                dataType : "json",
                contentType: "application/json; charset=utf-8",
                context: this,
                data: JSON.stringify({name: this.name}),
                cache: false,
                success: function(result) {
                    this.salt = result.salt;
                    this.perform_auth();
                },
                error: function(result) {
                    this.$dispatch('login', false);
                    alert('Username or password not recognized');
                }
            });
        },
        perform_auth: function() {
            var auth_payload = this.auth_payload;
            $.ajax({
                method: 'POST',
                url: '/api/auth_user',
                dataType : "json",
                contentType: "application/json; charset=utf-8",
                context: this,
                cache: false,
                data: JSON.stringify(auth_payload),
                success: function(result) {
                    this.uuid = result.uuid;
                    this.$dispatch('login', true);
                    this.$route.router.go('home');
                },
                error: function(result) {
                    this.$dispatch('login', false);
                    alert('Username or password not recognized');
                }
            });           
        }
    },
    computed: {
        'name_is_valid': function() {
            return !/[^a-zA-Z0-9\-\\_\/]/.test(this.name);
        },
        'pw_is_valid': function() {
            if (this.password.length < 8 ) {
                return false;
            };
            return true;
        },
        'can_submit': function() {
            if (this.name_is_valid && this.pw_is_valid) return true;
            return false;
        },
        'auth_payload': function() {
            var hasher = new jsSHA("SHA-512", "TEXT");
            hasher.update(this.password+this.salt);
            this.hash = hasher.getHash("HEX");
            return {name: this.name, hash: this.hash};
        }

    }
</script>


</component>