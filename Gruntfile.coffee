module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    
    # Store your Package file so you can reference its specific data whenever necessary
    pkg: grunt.file.readJSON("package.json")
    
    # Minify (Vendor) CSS
    cssmin: 
      normalize: 
        src: "bower_components/normalize-css/normalize.css"
        dest: "wintersmith/contents/css/normalize.min.css"

    # Yahoo's Smush.it for image compression
    smushit: 
      build: 
        src: [
          "images/*.png",
          "images/*.jpg"
        ]
        dest: 'wintersmith/contents/images'
          
    # Sass 
    sass:
      build:
        options:
          style: "compressed"
        require: ['sass/helpers/url64.rb']
        expand: true
        cwd: "sass/"
        src: ["styles.scss"]
        dest: "wintersmith/contents/css/"
        ext: ".css"
      preview:
        options:
          style: "expanded"
          debugInfo: true
          lineNumbers: true
        require: ['sass/helpers/url64.rb']
        expand: true
        cwd: "sass/"
        src: ["styles.scss"]
        dest: "wintersmith/contents/css/"
        ext: ".css"

    # Coffeescript
    coffee:
      join:
        options:
          join: true
        files:
          # "wintersmith/contents/js/test.js": "coffee/test.coffee" # 1:1 compile
          "wintersmith/contents/js/main.js": ["coffee/*.coffee"] # compile and concat into single file
      # compile: 
      #   files: 
      #     'wintersmith/contents/js/test.js': 'coffee/test.coffee', # 1:1 compile
      #     'wintersmith/contents/js/test2.js': ['coffee/*.coffee'] # compile and concat into single file
    
    # Concatenation
    concat:
      options:
        separator: ";"
      libs:
        src: [
          "bower_components/jquery/jquery.min.js"
          # "bower_components/path/to/additional.js"
        ]
        dest: "wintersmith/contents/js/libs.js"

    # Watch
    watch:
      sass:
        files: ["**/*.scss"]
        tasks: ["sass:preview"]
        options:
          spawn: false
      coffee:
        files: ["**/*.coffee"]
        tasks: ["coffee:join"]
        options:
          spawn: false
      images:
        files: [
          "images/*.png",
          "images/*.jpg"
        ]
        tasks: ["shushit:build"]
        options:
          spawn: false

    # Wintersmith
    wintersmith:
      build:
        options:
          action: "build"
          config: "wintersmith/config-build.json"
      preview:
        options:
          action: "preview"
          config: "wintersmith/config-preview.json"

  
  # Load NPM Tasks
  grunt.loadNpmTasks "grunt-css"
  grunt.loadNpmTasks "grunt-smushit"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-wintersmith"

  
  # Default Task
  # todo: run multiple continuos tasks
  
  # Preview Task
  grunt.registerTask "preview", ["wintersmith:preview"]
  
  # Release Task
  grunt.registerTask "build", ["cssmin", "concat", "smushit:build", "sass:build", "coffee:join", "wintersmith:build"]
