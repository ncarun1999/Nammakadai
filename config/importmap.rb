# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'flowbite', to: 'https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.8.1/flowbite.turbo.min.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin "tailwindcss-stimulus-components" # @4.0.4
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"
