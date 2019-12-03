<template>
  <section class="section">
    <h2 class="title is-3 has-text-grey">
      Set {{ user.name }}( {{ user.username }} )'s Roles
      <b-icon icon="rocket" size="is-large" />
    </h2>
    <div v-for="item in $store.state.roles.list" :key="item.id" class="field">
      <b-checkbox v-model="roleIds" :native-value="item.id">
        {{ item.name }}
      </b-checkbox>
    </div>
    <p class="content">
      <b>Selection:</b>
      {{ roleIds }}
    </p>
    <b-button type="is-info" @click="save()">Save</b-button>
  </section>
</template>
<script>
import { mapMutations } from 'vuex'

export default {
  data() {
    return {
      userId: 0,
      user: {
        username: '',
        name: ''
      },
      roleIds: []
    }
  },
  async created() {
    this.userId = this.$route.params.id
    if (isNaN(parseInt(this.userId, 10))) {
      this.$router.push('/users')
    }
    try {
      const res = await this.$axios.get('users/' + this.userId)
      if (!res.data) {
        throw new Error('User not found')
      }
      this.user.name = res.data.name
      this.user.username = res.data.username
      this.roleIds = res.data.roles.map(role => role.id)
      this.fetch()
    } catch (err) {
      this.$snackbar.open({
        message: err.message,
        onAction: () => {
          this.$router.push('/users')
        }
      })
    }
  },
  methods: {
    ...mapMutations({
      fetch: 'roles/fetch'
    }),
    save() {
      this.$axios
        .put(`management/users/${this.userId}/roles`, {
          roleIds: this.roleIds.map(roleId => parseInt(roleId, 10))
        })
        .then(res => {
          this.$buefy.toast.open({
            message: 'Saved!',
            type: 'is-success'
          })
          this.$router.push('/users')
        })
    }
  }
}
</script>
