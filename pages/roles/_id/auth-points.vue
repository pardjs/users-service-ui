<template>
  <section class="section">
    <h2 class="title is-3 has-text-grey">
      Set Role({{ role.name }})'s AuthPoints
      <b-icon icon="rocket" size="is-large" />
    </h2>
    <section>
      <div class="block">
        <div
          v-for="authPoint in $store.state.authPoints.list"
          :key="authPoint.id"
          class="field"
        >
          <b-checkbox v-model="checkboxGroup" :native-value="authPoint.id">
            {{ authPoint.name }} ( {{ authPoint.displayName }} )
          </b-checkbox>
        </div>
      </div>
      <p class="content">
        <b>Selection:</b>
        {{ checkboxGroup }}
      </p>
      <b-button type="is-primary" @click="save()">Save</b-button>
    </section>
  </section>
</template>
<script>
import { mapMutations } from 'vuex'

export default {
  data() {
    return {
      id: 0,
      role: {
        name: ''
      },
      checkboxGroup: []
    }
  },
  created() {
    this.id = +this.$route.params.id
    this.fetchAuthPoints()
    this.$axios.get('roles/' + this.id).then(res => {
      this.role = { ...res.data }
      console.log(res.data)
      this.checkboxGroup = res.data.authPoints.map(p => p.id)
    })
  },
  methods: {
    ...mapMutations({
      fetchAuthPoints: 'authPoints/fetch'
    }),
    save() {
      this.$axios
        .put(`roles/${this.id}/auth-points`, {
          authPointIds: this.checkboxGroup
        })
        .then(res => {
          this.$buefy.toast.open({
            message: 'Saved!',
            type: 'is-success'
          })
          this.$router.push('/roles')
        })
        .catch(err => {
          console.error(err)
          this.$buefy.toast.open({
            message: 'Error accurred!',
            type: 'is-danger'
          })
        })
    }
  }
}
</script>
