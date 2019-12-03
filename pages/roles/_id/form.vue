<template>
  <section class="section">
    <h2 class="title is-3 has-text-grey">
      {{ title }} role
      <b-icon icon="rocket" size="is-large" />
    </h2>
    <section>
      <b-field label="Name">
        <b-input v-model="role.name"></b-input>
      </b-field>
      <b-button type="is-primary" @click="save()">Save</b-button>
    </section>
  </section>
</template>
<script>
export default {
  data() {
    return {
      title: 'New',
      id: 'new',
      role: {
        name: ''
      }
    }
  },
  created() {
    if (this.$route.params.id !== 'new') {
      this.id = this.$route.params.id
      this.title = 'Edit'
      this.$axios.get('roles/' + this.id).then(res => {
        this.role.name = res.data.name
      })
    }
  },
  methods: {
    async save() {
      if (this.id === 'new') {
        await this.$axios.post('roles', this.role)
      } else {
        const data = { ...this.role }
        await this.$axios.put('roles/' + this.id, data)
      }
      this.$router.push('/roles')
    }
  }
}
</script>
