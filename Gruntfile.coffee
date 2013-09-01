module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    
    # Store your Package file so you can reference its specific data whenever necessary
    pkg: grunt.file.readJSON("package.json")
      
    # Sass 
    sass:
      
      prod:
        options:
          style: "compressed"

        # require: ['./sass/helpers/url64.rb']
        expand: true
        cwd: "app/sass/"
        src: ["styles.scss"]
        dest: "app/contents/css/"
        ext: ".css"

      dev:
        options:
          style: "expanded"
          debugInfo: true
          lineNumbers: true

        
        # require: ['/sass/helpers/url64.rb']
        expand: true
        cwd: "app/sass/"
        src: ["styles.scss"]
        dest: "app/contents/css/"
        ext: ".css"

    # Coffeescript
    coffee:
      
      compile: 
        files: 
          'app/contents/js/test.js': 'app/coffee/test.coffee', # 1:1 compile
          'app/contents/js/test2.js': ['app/coffee/*.coffee'] # compile and concat into single file

      join:
        options:
          join: true

        files:
          "app/contents/js/test.js": "app/coffee/test.coffee" # 1:1 compile
          "app/contents/js/application.js": ["app/coffee/*.coffee"] # compile and concat into single file

    # Concatenation
    concat:
      options:
        separator: ";"

      prod:
        src: [
        
          "app/bower_components/jquery/jquery.min.js"
          # "app/bower_components/path/to/additional.js"
        
        ]
        
        dest: "app/contents/js/library.js"

    # Watch
    watch:
      
      prod:
        files: ["**/*.scss"]
        tasks: ["sass:prod"]
        options:
          spawn: false

      dev:
        files: ["**/*.scss"]
        tasks: ["sass:dev"]
        options:
          spawn: false
    
    # Add Imagemin

    # Wintersmith
    wintersmith:
      prod:
        options:
          action: "build"
          config: "app/config-prod.json"

      dev:
        options:
          action: "preview"
          config: "app/config-dev.json"

  
  # Load NPM Tasks
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"
  # grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-wintersmith"
  
  # Default Task
  # grunt.registerTask "default", ["sass:dev", "coffee:join"]
  
  # Preview Task
  grunt.registerTask "preview", ["watch:dev", "coffee:join", "wintersmith:dev"]
  
  # Release Task
  grunt.registerTask "prod", ["sass:prod", "coffee:join", "wintersmith:prod"]
