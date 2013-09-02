// Generated by CoffeeScript 1.6.3
module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON("package.json"),
    cssmin: {
      normalize: {
        src: "bower_components/normalize-css/normalize.css",
        dest: "wintersmith/contents/css/normalize.min.css"
      }
    },
    smushit: {
      build: {
        src: ['images/*.png', 'images/*.jpg'],
        dest: 'wintersmith/contents/images'
      }
    },
    sass: {
      build: {
        options: {
          style: "compressed"
        },
        require: ['sass/helpers/url64.rb'],
        expand: true,
        cwd: "sass/",
        src: ["styles.scss"],
        dest: "wintersmith/contents/css/",
        ext: ".css"
      },
      preview: {
        options: {
          style: "expanded",
          debugInfo: true,
          lineNumbers: true
        },
        require: ['sass/helpers/url64.rb'],
        expand: true,
        cwd: "sass/",
        src: ["styles.scss"],
        dest: "wintersmith/contents/css/",
        ext: ".css"
      }
    },
    coffee: {
      join: {
        options: {
          join: true
        },
        files: {
          "wintersmith/contents/js/main.js": ["coffee/*.coffee"]
        }
      }
    },
    concat: {
      options: {
        separator: ";"
      },
      libs: {
        src: ["bower_components/jquery/jquery.min.js"],
        dest: "wintersmith/contents/js/libs.js"
      }
    },
    watch: {
      build: {
        files: ["**/*.scss"],
        tasks: ["sass:build"],
        options: {
          spawn: false
        }
      },
      preview: {
        files: ["**/*.scss"],
        tasks: ["sass:preview"],
        options: {
          spawn: false
        }
      }
    },
    wintersmith: {
      build: {
        options: {
          action: "build",
          config: "wintersmith/config-build.json"
        }
      },
      preview: {
        options: {
          action: "preview",
          config: "wintersmith/config-preview.json"
        }
      }
    }
  });
  grunt.loadNpmTasks("grunt-css");
  grunt.loadNpmTasks("grunt-smushit");
  grunt.loadNpmTasks("grunt-contrib-sass");
  grunt.loadNpmTasks("grunt-contrib-coffee");
  grunt.loadNpmTasks("grunt-contrib-concat");
  grunt.loadNpmTasks("grunt-contrib-watch");
  grunt.loadNpmTasks("grunt-wintersmith");
  grunt.registerTask("preview", ["wintersmith:preview", "watch:preview", "coffee:join"]);
  return grunt.registerTask("build", ["cssmin", "concat", "sass:build", "coffee:join", "wintersmith:build"]);
};
