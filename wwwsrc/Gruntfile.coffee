module.exports = (grunt) ->
  buildProperties = (done) ->
    json = grunt.config('build')
    json['build_date'] = new Date().toString()
    done(json)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean:
      dist: ['dist']
      distNodeModulesJs: ['dist/node_modules']
      www: ['../www', '!../www/.gitignore']
      options:
        # This overrides this task from blocking deletion of folders outside current working dir (CWD). Use with caution.
      	force: true

    phpunit:
      unit:
        dir: 'tests'
      options:
        bin: 'vendor/bin/phpunit'
        colors: true
        logJunit: 'tests/report.xml'
        followOutput: true
        stopOnError: true
        stopOnFailure: true

    sass:
      dist:
        files: [{
          expand: true
          cwd: 'styles'
          src: ['*.scss']
          dest: 'css'
          ext: '.css'
        }]

    coffee:
      dist:
        files: [{
          expand: true
          cwd: 'scripts'
          src: ['*.coffee']
          dest: 'js'
          ext: '.js'
        }]

    copy:
      dist:
        files: [{
          expand: true,
          cwd: '.'
          src: ['index.html', 'css/**/*', 'js/**/*', 'img/**/*']
          dest: 'dist'
        }]

      nodeModulesJs:
        files: [{
          expand: true
          cwd: 'node_modules/'
          src: ['**/*.js']
          dest: 'dist/node_modules/'
        }]
       
       www: 
        files: [{
          expand: true,
          cwd: 'dist'
          src: ['**/*']
          dest: '../www/'
        }]

    replace:
      options:
        patterns: [{
          json: buildProperties
        }]

      dist:
        files: [{
          src: 'dist/index.html'
          dest: 'dist/index.html'
        }]

    useminPrepare:
      html: 'dist/index.html'

    usemin:
      html: ['dist/index.html']

    watch:
      styles:
        files: ['**/*.scss']
        tasks: ['sass']

      scripts:
        files: ['**/*.coffee']
        tasks: ['coffee']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-replace'
  grunt.loadNpmTasks 'grunt-usemin'

  grunt.registerTask 'setup-env', "Set up the development environment variables", ->
    grunt.config('options.env', 'dev')
    grunt.config('options.env', grunt.option('env')) if grunt.option('env')

    # now load build properties
    grunt.config('build', grunt.file.readJSON("build." + grunt.config('options.env') + ".json"))

    grunt.log.writeflags(grunt.config('build'), "Build properties loaded from environment " + grunt.config('options.env'))

  grunt.registerTask 'test', "Run tests", []  # TODO

  grunt.registerTask 'build', "Build the static site", [
    'setup-env',
    'clean',
    'sass',
    'coffee',
    'copy:dist',
    'copy:nodeModulesJs',
    'replace:dist',
    'useminPrepare',
    'concat',
    'uglify',
    'usemin',
    'clean:distNodeModulesJs',
    'clean:www',
    'copy:www'
  ]

  grunt.registerTask 'serve', [
    'setup-env',
    'clean',
    'sass',
    'coffee',
    'watch'
  ]

  grunt.registerTask 'default', ['test']
