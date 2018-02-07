<component name="post">
<template lang="slim">
div
    .card.lb-post.w-100.mb-3.border-0
        img.card-img-top v-bind:src="post.picture" v-show="post.picture"
        .card-body
            h2.card-title.lb-title 
                | {{post.title}}
            p.card-text 
                | {{post.body}}
    hr
</template>

<script>
props: ["post"],
data: function() {
    return {
    }
},
methods: {
}
</script>

</component>
