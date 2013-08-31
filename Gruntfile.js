module.exports = function (grunt) {

  // Project configuration.
  grunt.initConfig({

    // Store your Package file so you can reference its specific data whenever necessary
    pkg: grunt.file.readJSON('package.json'),

    /*
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> | <%= pkg.version %> | <%= grunt.template.today("yyyy-mm-dd") %> /\n'
      },
      dist: {
        src: './<%= pkg.name %>.js',
        dest: './<%= pkg.name %>.min.js'
      }
    },
    */
    
    wintersmith: {
    
      build: {},
    
      preview: {
        
        options: {
          action: "preview"
        }
      
      }
    },

    sass: {
      
      dist: {
        options: {
          style: 'compressed'
          // require: ['./sass/helpers/url64.rb']
        },
        expand: true,
        cwd: 'sass/',
        src: ['styles.scss'],
        dest: 'app/contents/css/',
        ext: '.css'
      },
      
      dev: {
        options: {
          style: 'expanded',
          debugInfo: true,
          lineNumbers: true
          // require: ['/sass/helpers/url64.rb']
        },
        expand: true,
        cwd: 'sass/',
        src: ['styles.scss'],
        dest: 'app/contents/css/',
        ext: '.css'
      }
    
    },

    coffee: {
      // compile: {
      //   files: {
      //     'app/contents/js/test.js': 'coffee/test.coffee', // 1:1 compile
      //     'app/contents/js/test2.js': ['coffee/*.coffee'] // compile and concat into single file
      //   }
      // },

      join: {
        options: {
          join: true
        },
        files: {
          'app/contents/js/test.js': 'coffee/test.coffee', // 1:1 compile
          'app/contents/js/test2.js': ['coffee/*.coffee'] // compile and concat into single file
        }
      }

    },

    // `optimizationLevel` is only applied to PNG files (not JPG)
    imagemin: {
      
      png: {
        
        options: {
          optimizationLevel: 7
        },
        
        files: [
          {
            expand: true,
            cwd: './app/images/',
            src: ['**/*.png'],
            dest: './app/images/compressed/',
            ext: '.png'
          }
        ]
      
      },
      
      jpg: {
        
        options: {
          progressive: true
        },
        
        files: [
          {
            expand: true,
            cwd: './app/images/',
            src: ['**/*.jpg'],
            dest: './app/images/compressed/',
            ext: '.jpg'
          }
        ]
      }
    },

    watch: {
      sass_dist: {
        files: ['**/*.scss'],
        tasks: ['sass:dist'],
        options: {
          spawn: false,
        },
      },
      sass_dev: {
        files: ['**/*.scss'],
        tasks: ['sass:dev'],
        options: {
          spawn: false,
        },
      }
    },

  });

  // Load NPM Tasks
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-wintersmith');



  // Default Task
  grunt.registerTask('default', ['sass:dev', 'coffee:compile']);

  // Preview Task
  grunt.registerTask('preview', ['sass:dev', 'coffee:compile']);

  // Release Task
  grunt.registerTask('release', ['sass:dist', 'coffee:compile', 'imagemin']);

  /*
    Notes: 

    When registering a new Task we can also pass in any other registered Tasks.
    e.g. grunt.registerTask('release', 'default requirejs'); // when running this task we also run the 'default' Task

    We don't do this above as we would end up running `sass:dev` when we only want to run `sass:dist`
    We could do it and `sass:dist` would run afterwards, but that means we're compiling sass twice which (although in our example quick) is extra compiling time.

    To run specific sub tasks then use a colon, like so...
    grunt sass:dev
    grunt sass:dist
  */

};