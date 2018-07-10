$(document).on('turbolinks:load', function () {
  if ($('.c-result-default').length) {


    /**
    *
    *
    *
    *         INITIAL STATE 
    *
    *
    *
    *
    **/
    var collect_aids_per_contract = function(eligy){
      return $('#' + eligy + ' .c-resultcard').map(function(){return $(this).data()["cslug"]}).get();
    }
    var collect_aids = function(eligy, contract_name){
      return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid').map(function(){return $(this).data()["aslug"]}).get();
    }
    var collect_filters = function(eligy, contract_name, aid_name){
      return $('#' + eligy + ' .c-resultcard[data-cslug="'+contract_name+'"]' + ' .c-resultaid[data-aslug="'+aid_name+'"] .c-resultfilter').map(function(){return $(this).data()["name"]}).get();
    }

    var initial_eligy = function(eligy) {
      return _.map(
        collect_aids_per_contract(eligy), 
        function(contract_name){
          return {
            name: contract_name, 
            is_collapsed: false,
            aids: _.map(
              collect_aids(eligy, contract_name), 
              function(aid_name) {
                return {
                  name: aid_name,
                  is_collapsed: false,
                  filters: _.map(
                    collect_filters(eligy, contract_name, aid_name),
                    function(filter_name) {
                      return {
                        name: filter_name,
                        is_shown: false,
                      }
                    }
                  )
                }
              }
            )
          }
        }
      );
    }

    window.initial_state = {
      eligibles_zone: {
        eligibles: initial_eligy('o_eligibles')
      },
      uncertains_zone: {
        uncertains: initial_eligy('o_uncertains')
      },
      ineligibles_zone: {
        is_collapsed: true,
        ineligibles: initial_eligy('o_ineligibles')
      },
      filters_zone: {
        is_collapsed: false,
        filters: _.map($('#o_all_filters .c-resultfiltering').map(function(){return $(this).data()["name"]}).get(), function(e){return {name: e, is_checked: false}})
      },
      recap_zone: {
        is_collapsed: false
      }
    };


    /**
    *
    *
    *
    *         MAIN REDUCER 
    *
    *
    *
    *
    **/
    function main_reducer(state, action) {
      if (state === undefined) {
        return initial_state;
      }

      // Works better than _.assign or Object.assign
      var newState = JSON.parse(JSON.stringify(state));

      if (action.type === 'TOGGLE_FILTERS_ZONE') {
        _.set(newState, 'filters_zone.is_collapsed', !_.get(newState, 'filters_zone.is_collapsed'));
      }


      return newState;
    }


    /**
    *
    *
    *
    *         MAIN STORE 
    *
    *
    *
    *
    **/
    window.main_store = Redux.createStore(main_reducer, initial_state);


    /**
    *
    *
    *
    *         DISPATCHERS 
    *
    *
    *
    *
    **/
    $('.js-filters-zone').on('click', function(){main_store.dispatch({type: 'TOGGLE_FILTERS_ZONE'})})

    main_store.dispatch({ type: 'INIT' });


    /**
    *
    *
    *
    *         SUBSCRIBERS
    *
    *
    *
    *
    **/
    main_store.subscribe(function() {

      main_store.getState().filters_zone.is_collapsed ? $('.c-resultfilterings').addClass('u-hidden-visually') : $('.c-resultfilterings').removeClass('u-hidden-visually');

      

    })
    


  }
});


