<component name="blog">
<template lang="slim">
.container-fluid
    .row
        .col-md-7.offset-md-1
            post :post="post"
            router-link.card-link.lb-link v-if="can_go_back"    v-bind:to="post_url(prev_id)" Older
            router-link.card-link.lb-link v-if="can_go_forward" v-bind:to="post_url(next_id)" Newer
        .col-md-3
            .card.position-fixed
                .card-body 
                    p This iwll be the menu
</template>

<script>
data: function() {
    return {
        post: {
            title: "", 
            body:  "", 
            id:    0, 
            image: ""
        },
        first: 0,
        last:  0
    }
},
methods: {
    get_id_range: function() {
        XHR({
            method: 'GET',
            url: "/post/range"
        }).success(function (data) {
            this.first = data.first;
            this.last  = data.last;
        }.bind(this));
    },
    get_post: function() {
        XHR({
            method: 'GET',
            url: "/post/" + this.$route.params.postid
        }).success(function (data) {
            this.post = data;
        }.bind(this));
    },
    get_latest_post: function() {
        XHR({
            method: 'GET',
            url: "/post/latest"
        }).success(function (data) {
            this.post = data;
            router.push({ name: 'blog', params: { postid: data.id }})
        }.bind(this));
    },
    post_url: function(id) {
        return "/blog/" + id
    }
},
computed: {
    can_go_back: function() { return this.post.id > this.first },
    can_go_forward: function() { return this.post.id < this.last },
    next_id: function() { a = parseInt(this.post.id); return a += 1 },
    prev_id: function() { a = parseInt(this.post.id); return a -= 1},
    id_in_url: function() { return this.$route.params.postid}
},
watch: {
    id_in_url: function() {
        this.get_post();
    }
},
mounted: function() {
    this.get_id_range();
    if (!this.id_in_url) {
        this.get_latest_post();
    } else {
        this.get_post();
    }
}
</script>

</component>