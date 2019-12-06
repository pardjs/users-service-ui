import Vue from 'vue'

export function yesNo(boolValue) {
  return boolValue ? 'Yes' : 'No'
}

Vue.filter('yesNo', yesNo)
