<template>
  <section class="section">
    <div class="columns is-mobile">
      <card title="Users" icon="account">
        <nuxt-link to="users">Users</nuxt-link>
      </card>
      <card title="Roles" icon="account-multiple">
        <nuxt-link to="roles">Roles</nuxt-link>
      </card>
      <card title="Auth Points" icon="circle-edit-outline">
        <nuxt-link to="auth-points">Auth Points</nuxt-link>
      </card>
    </div>
  </section>
</template>

<script>
import Card from '~/components/Card'

export default {
  name: 'HomePage',

  components: {
    Card
  }
}
</script>
