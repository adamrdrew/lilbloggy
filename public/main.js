var routes = [
    {name: "login", path: '/login', component: login_form},
    {name: "blog", path: '/', component: blog}
]

var router = new VueRouter({
    routes: routes,
    mode: 'history'
})

var store = new Vuex.Store({
    state: {
        data: [],
    },
    getters: {
    },
    mutations: {
    }
});

var app = new Vue({
    el: "#vue_app",
    router: router,
    store: store, 
    data: {
    },
    methods: {

     }
});