module.exports = (grunt) ->

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        files: [
          {
            expand: true,
            cwd: 'src/',
            src: ['**/*.coffee'],
            dest: 'target/',
            ext: '.js'
          }
        ]
      }
    },
    browserify: {
      main: {
        src: ['target/synchrodecoder.js'],
        dest: 'dist/synchrodecoder.js',
        options: {
          alias: []
        }
      }
    },
    uglify: {
      main: {
        files: {
          'dist/synchrodecoder.min.js': ['dist/synchrodecoder.js']
        }
      }
    }
    copy: {
      publish: {
        files: [
          {
            src: ['package.json', 'README.md']
          , dest: 'dist/'
          }
        ],
      }
    }
  })

  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-uglify-es')

  grunt.registerTask('default', ['coffee', 'browserify', 'uglify', 'copy:publish'])
