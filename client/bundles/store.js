import thunk from 'redux-thunk';
import { createStore, applyMiddleware } from 'redux';
import { composeWithDevTools } from 'redux-devtools-extension';

import reducers from './reducers';

import { userSignIn } from "./Authentication/actions/authenticationActions";
import setAuthorizationHeader from "./utils/setAuthorizationHeader";

const configureStore = (railsProps) => {
    const store = createStore(
      reducers,
      railsProps,
      composeWithDevTools(applyMiddleware(thunk))
    )

  if(localStorage.token){
    const user = {
      token: localStorage.token
    };

    setAuthorizationHeader(localStorage.token);
    store.dispatch(userSignIn(user));
  }

  return store;
}

export default configureStore;
