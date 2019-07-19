clara.js_define("admin_trundle_subscriber", {

    please_if: _.stubFalse,

    please: function(state) {


      var s = state
      var $root = $(".root_box")
      var $varopval = $("section.varopval")
      $root.empty()
      var walk_nodes = this.walk_nodes;
      $("#main-apprule-expl").empty();
     
      if (_.size(s.subboxes) === 0) {
        $varopval.appendTo($root);
        $varopval.show();
      } else {
        walk_nodes(s)
      }
     
      // if (_.size(s.subboxes) === 1 && !$(".template_nb_1").exists()) {
      //   var $root = $(".root_box")
      //   $("#main-apprule-expl").hide()
      //   $("#main-apprule-expl").html(this.first_expl)
      //   $("#main-apprule-expl").show(600)
      //   $(this.first_template(s.subboxes[0].xtxt, "template_nb_1")).appendTo($root)
      // }

      // if (_.size(s.subboxes) === 2 && !$(".template_nb_2").exists()) {
      //   var $root = $(".root_box")
      //   $("#main-apprule-expl").hide()
      //   $(this.first_template(s.subboxes[1].xtxt)).appendTo($root)
      // }


    },

    walk_nodes: function(obj) {
      var that = clara.admin_trundle_subscriber;
      var parent_name = obj.name;
      if (_.size(obj.subboxes) > 0) {
        _.each(obj.subboxes, function(subbox) {
          that.paint_node(subbox, parent_name);
          that.walk_nodes(subbox);
        })
      }
    },

    paint_node: function(node, parent_name) {
      var that = clara.admin_trundle_subscriber;
      console.log("painting " + node.name + " with parent " + parent_name)
      var $parent = $("." + parent_name)
      $(that.first_template(node.xtxt, node.name, parent_name)).appendTo($parent)
    },


    first_expl: '<div>\
                    Si c\'est la seule règle, vous pouvez passer au critère géographique ci-dessous.\
                 </div>\
                 <div>\
                   Sinon, cliquez sur la règle.\
                 </div>\
                ',

    first_template: function(title, name, parent_name) {
      return '<ul class="unsortable ui-sortable ' + name + '">\
          <li class="unsortable ui-sortable-handle">\
            <span class="combinator-container">\
              <button class="js-tooltip like-a-link add-condition" data-tooltip-content-id="tooltip_id_condition" data-tooltip-title="' + title +'" data-tooltip-prefix-class="combinator" data-tooltip-close-text="x" data-tooltip-close-title="Ferme la fenêtre" id="label_tooltip_2">' +
                title +
              '</button>\
            </span>\
            <div id="tooltip_id_condition" class="hidden">\
              <div>\
                <button class="like-a-link add-condition-and" onclick=\'store_trundle.dispatch({ type: "ADD_CONDITION", combination: "AND", parent_box: "' + parent_name + '" });\'>ET une nouvelle condition</button>\
              </div>\
              <div>\
                <button class="like-a-link add-condition-or">OU une nouvelle condition</button>\
              </div>\
              <div>\
                <button class="like-a-link add-condition-or">regrouper avec une nouvelle sous-condition, liée par un OU</button>\
              </div>\
              <div>\
                <button class="like-a-link add-condition-or">regrouper avec une nouvelle sous-condition, liée par un ET</button>\
              </div>\
              <div>\
                <button class="like-a-link edit-condition">Editer cette condition</button>\
              </div>\
              <div>\
                <button class="like-a-link close-window">Fermer cette fenêtre</button>\
              </div>\
            </div>\
          </li>\
          <li class="unsortable">\
          </li>\
        </ul>\
      '
  },
});

