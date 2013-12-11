module.exports = (grunt) ->
    "use strict"

    grunt.initConfig
        clean: ["dist/"]

        coffee:
            main:
                files:
                    "dist/assets/js/app.js": "site/js/app.coffee"

        connect:
            server:
                options:
                    hostname: "localhost"
                    port: 8080
                    base: "dist/"
                    livereload: true

        copy:
            main:
                files: [
                    {
                        src: ['*']
                        dest: 'dist/'
                        cwd: 'site/'
                        filter: 'isFile'
                        expand: true
                    },
                    {
                        src: ['**']
                        dest: 'dist/assets/img/'
                        cwd: 'site/img/'
                        filter: 'isFile'
                        expand: true
                    }
                ]

        less:
            main:
                options:
                    paths: ["site/less"]
                files:
                    "dist/assets/css/app.css": "site/less/app.less"

        watch:
            options:
                livereload: true
            coffee:
                files: ["site/js/*.coffee"]
                tasks: ["coffee"]
            copy:
                files: ["site/img/**", "site/*"]
                tasks: ["copy"]
            less:
                files: ["site/less/*.less"]
                tasks: ["less"]

    grunt.loadNpmTasks "grunt-contrib-clean"
    grunt.loadNpmTasks "grunt-contrib-coffee"
    grunt.loadNpmTasks "grunt-contrib-connect"
    grunt.loadNpmTasks "grunt-contrib-copy"
    grunt.loadNpmTasks "grunt-contrib-less"
    grunt.loadNpmTasks "grunt-contrib-watch"

    grunt.registerTask "default", [
        "clean", "copy", "less", "coffee", "connect", "watch"
    ]
