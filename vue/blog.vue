<component name="blog">
<template lang="slim">
.container-fluid
    .row
        .col-md-7.offset-md-1
            post v-for="post in posts" :post="post" :key="post.id"
        .col-md-3
            .card.position-fixed
                .card-body 
                    p Hello World
</template>

<script>
data: function() {
    return {
        posts: [
            {title: "This is a post", body: "This is a super great post!", id:123, image: "http://4.bp.blogspot.com/-dsGVHCka_Vw/T9tG6vYsh2I/AAAAAAAAAkM/ztGXwGbApkA/s1600/david-bowie-001.jpg"},
            {title: "This is a an olderpost", body: "This was a super great post!", id:122},
            {title: "This is a post", body: "This is a super great post!", id:123, image: "http://4.bp.blogspot.com/-dsGVHCka_Vw/T9tG6vYsh2I/AAAAAAAAAkM/ztGXwGbApkA/s1600/david-bowie-001.jpg"},
            {title: "This is a post", body: "This is a super great post!", id:123, image: "http://4.bp.blogspot.com/-dsGVHCka_Vw/T9tG6vYsh2I/AAAAAAAAAkM/ztGXwGbApkA/s1600/david-bowie-001.jpg"},
            {title: "This is a an olderpost", body: "This was a super great post!", id:122},
            {title: "This is a an olderpost", body: "This was a super great post!", id:122},
            {title: "This is a post", body: "This is a super great post!", id:123, image: "http://4.bp.blogspot.com/-dsGVHCka_Vw/T9tG6vYsh2I/AAAAAAAAAkM/ztGXwGbApkA/s1600/david-bowie-001.jpg"},
            {title: "This is a an olderpost", body: "This was a super great post!", id:122},
            {title: "This is a post", body: "This is a super great post!", id:123, image: "http://4.bp.blogspot.com/-dsGVHCka_Vw/T9tG6vYsh2I/AAAAAAAAAkM/ztGXwGbApkA/s1600/david-bowie-001.jpg"},
            {title: "This is a post", body: "This is a super great post!", id:123, image: "http://4.bp.blogspot.com/-dsGVHCka_Vw/T9tG6vYsh2I/AAAAAAAAAkM/ztGXwGbApkA/s1600/david-bowie-001.jpg"},
            {title: "This is a an olderpost", body: "This was a super great post!", id:122},
            {title: "This is a an olderpost", body: "This was a super great post!", id:122},
            {title: "This is a post", body: "This is a super great post!", id:123, image: "http://4.bp.blogspot.com/-dsGVHCka_Vw/T9tG6vYsh2I/AAAAAAAAAkM/ztGXwGbApkA/s1600/david-bowie-001.jpg"},
            {title: "This is a an olderpost", body: "This was a super great post!", id:122}
        ]    
    }
},
methods: {
},
computed: {
}
</script>

</component>