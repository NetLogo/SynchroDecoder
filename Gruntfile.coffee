{ nodeResolve: resolve } = require('@rollup/plugin-node-resolve')
commonjs                 = require('@rollup/plugin-commonjs')

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
            ext: '.mjs'
          }
        ]
      }
    },
    rollup: {
      main: {
        options: {
          plugins: [resolve({ browser: true, preferBuiltins: false }), commonjs()]
        }
        files: {
          'dist/synchrodecoder.mjs': ['target/synchrodecoder.mjs']
        }
      }
    }
    terser: {
      main: {
        files: {
          'dist/synchrodecoder.min.mjs': ['dist/synchrodecoder.mjs']
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

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-rollup')
  grunt.loadNpmTasks('grunt-terser')

  grunt.registerTask('default', ['coffee', 'rollup', 'terser', 'copy:publish'])
