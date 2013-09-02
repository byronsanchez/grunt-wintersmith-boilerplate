module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    
    # Store your Package file so you can reference its specific data whenever necessary
    pkg: grunt.file.readJSON("package.json")
      
    # Sass 
    sass:
      build:
        options:
          style: "compressed"

        # require: ['./sass/helpers/url64.rb']
        expand: true
        cwd: "app/sass/"
        src: ["styles.scss"]
        dest: "app/contents/css/"
        ext: ".css"

      preview:
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
      # compile: 
      #   files: 
      #     'app/contents/js/test.js': 'app/coffee/test.coffee', # 1:1 compile
      #     'app/contents/js/test2.js': ['app/coffee/*.coffee'] # compile and concat into single file

      join:
        options:
          join: true

        files:
          # "app/contents/js/test.js": "app/coffee/test.coffee" # 1:1 compile
          "app/contents/js/main.js": ["app/coffee/*.coffee"] # compile and concat into single file
    
    # Minify CSS
    cssmin: 
        normalize: 
          
          src: "app/bower_components/normalize-css/normalize.css"
          
          dest: "app/contents/css/normalize.min.css"
        
    # Concatenation
    concat:
      options:
        separator: ";"

      libs:
        src: [
          "app/bower_components/jquery/jquery.min.js"
          # "app/bower_components/path/to/additional.js"
        ]
        
        dest: "app/contents/js/libs.js"

    # Watch
    watch:
      build:
        files: ["**/*.scss"]
        tasks: ["sass:build"]
        options:
          spawn: false

      preview:
        files: ["**/*.scss"]
        tasks: ["sass:preview"]
        options:
          spawn: false

    # Wintersmith
    wintersmith:
      build:
        options:
          action: "build"
          config: "app/config-build.json"

      preview:
        options:
          action: "preview"
          config: "app/config-preview.json"

  
  # Load NPM Tasks
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-css"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-wintersmith"
  
  # Default Task
  # grunt.registerTask "default", ["sass:preview", "coffee:join"]
  
  # Preview Task
  grunt.registerTask "preview", ["wintersmith:preview", "watch:preview", "coffee:join"]
  
  # Release Task
  grunt.registerTask "build", ["cssmin", "concat", "sass:build", "coffee:join", "wintersmith:build"]
