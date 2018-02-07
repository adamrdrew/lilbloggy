
var routes = [
    {name: "login",  path: '/login',         component: login_form},
    {name: "signup", path: '/signup',        component: signup_form},
    {name: "blog",   path: '/blog/:postid?', component: blog}
]

var router = new VueRouter({
    routes: routes,
    mode: 'history'
})

var store = new Vuex.Store({
    state: {
        config: {},
        user: {
            name: "",
            uuid: ""
        }
    },
    getters: {
        signup_enabled: state => { 
            return state.config.signup_enabled
        }
    },
    mutations: {
        config (state, config) {
            state.config = config
        },
        user (state, user) {
            state.user.name = user.name;
            state.user.uuid = user.uuid;
        }
    }
});

var app = new Vue({
    el: "#vue_app",
    router: router,
    store: store, 
    data: {
    },
    methods: {
        get_config: function() {
            XHR({
                method: 'GET',
                url: "/config"
            }).success(function (data) {
                this.$store.commit('config', data)
            }.bind(this));
        },
        get_logged_in_user: function() {
            XHR({
                method: 'GET',
                url: "/user/get",
            }).success(function (data) {
                this.$store.commit('user', data)
            }.bind(this));
        }
    },
    mounted: function() {
        this.get_logged_in_user();
    }
});