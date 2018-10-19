// load_js_for_page(["welcome", "index"], function() {
// });
/**
*
* Will load JavaScript file for page whose body has classes given in array_of_selectors.
*
* If first parameter is empty array, JavaScript will be loaded for the whole application.
*
* Usage : load_js_for_page(["welcome", "index"], function loaded_function() {});
*
* The JS will be loaded only once, whether "ready" or "turbolinks:load" is called.
*
*/

function load_js_for_page(selectors, a_function, optional_id) {

  var local_id = _.isEmpty(selectors) ? optional_id : selectors.toString();

  // extracted from https://stackoverflow.com/a/52466715/2595513
  function makeSelfDestructingEventCallback(maxExecutions) {
    return function(internal_callback) {
      // console.log("entering fcallback with selectors " + selectors)
      var count = 0;
      // var current_id = local_id;
      return function(event) {
        if (should_apply_on_all_pages() || should_apply_on_selected_page()) {
          count += 1;
        } else {
          return;
        }
        console.log("count of " +  local_id + " is " + count)
        if (count > maxExecutions){
          // $(this).off(event)
          count = 0;
          return;
        } else {
          // count = 0;
          //pass any normal arguments down to the wrapped callback
          return internal_callback.apply(this, arguments);          
        }
      }
    }
    
  }

  var only_one_possible_call = makeSelfDestructingEventCallback(1);



  var should_apply_on_all_pages = function(){
    return _.isEmpty(selectors);
  };

  var should_apply_on_selected_page = function(){ 
    var res = false;
    if(!_.isEmpty(selectors)){
      res = _.every(selectors, function(sel){return $('body').hasClass(sel)});
    }
    return res;
  };

  var callback = function(e) {
    console.log("function " + local_id + " is called with event " + event.type);
    a_function();
  };

  var func = _.cond([
    [should_apply_on_all_pages, callback],
    [should_apply_on_selected_page, callback]
  ]);

  
  // $(document).on("ready turbolinks:load", function(an_event) {only_one_possible_call(func)(an_event)});
  $(document).on("ready turbolinks:load", only_one_possible_call(func));

};



//a curried wrapper that will ensure the callback "self-destructs" and will be unbound correctly
// function makeSelfDestructingEventCallback(maxExecutions) {
//   return function(callback) {
//     let count = 0;
//     return function(event) {
//       if (count++ >= maxExecutions){
//         $(this).off(event)
//         return;
//       }
//       //pass any normal arguments down to the wrapped callback
//       return callback.apply(this, arguments);
//     }
//   }
  
// }
// var one = makeSelfDestructingEventCallback(1);

// function callback(event) {
//   console.log("button clicked");
// }

// let two = makeSelfDestructingEventCallback(2);

// $('#clickme').on("click mousedown mouseup", one(callback));
// $('#clickme-two').on("click mousedown mouseup", two(callback));

  // $(document).on("ready turbolinks:load", function(event) {
  //   // if (_.isEmpty(selectors) || _.every(selectors, function(sel){return $('body').hasClass(sel)})) {
  //     var local_id = _.isEmpty(selectors) ? optional_id : selectors.toString();
  //     console.log("function " + local_id + " is called with event " + event.type);
  //     a_function();
  //   // }
  // });

// var func = _.cond([
//   [_.matches({ 'a': 1 }),           _.constant('matches A')],
//   [_.conforms({ 'b': _.isNumber }), _.constant('matches B')],
//   [_.stubTrue,                      _.constant('no match')]
// ]);
 
// func({ 'a': 1, 'b': 2 });
// // => 'matches A'
 
// func({ 'a': 0, 'b': 1 });
// // => 'matches B'
 
// func({ 'a': '1', 'b': '2' });
// // => 'no match'
