//= require custom/aides/aides_default_state.js
describe('aides_default_state.js', function() {

  describe('State is existing', function() {
    beforeEach(function() {
    });
    it('extract data from store thanks to state_key', function() {
      // given
      spyOn(clara.aides_state_key, "please").and.callFake(_.wrap("key_in_store"));
      spyOn(store, "get")
      // when
      res = clara.aides_default_state.please("my_initial_state");
      // then
      expect(store.get).toHaveBeenCalledWith("key_in_store");
    });
    it('returns given initial state if previous_state is not yet existing', function() {
      spyOn(store, "get").and.callFake(_.wrap(null));
      res = clara.aides_default_state.please("my_initial_state");
      expect(res).toEqual("my_initial_state");
    });
    it('returns given initial state if previous_state exists but as empty object', function() {
      spyOn(store, "get").and.callFake(_.wrap({}));
      res = clara.aides_default_state.please("my_initial_state");
      expect(res).toEqual("my_initial_state");
    });
    it('returns previous state if previous_state exists as non-empty object', function() {
      spyOn(store, "get").and.callFake(_.wrap({state:42}));
      res = clara.aides_default_state.please("my_initial_state");
      expect(res).toEqual({state:42});
    });
  });

});
  
