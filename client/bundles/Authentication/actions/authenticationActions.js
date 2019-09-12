import api from '../api';
import setAuthorizationHeader from '../../utils/setAuthorizationHeader';
import { USER_SIGN_IN, USER_SIGN_UP, MESSAGE } from '../constants/authenticationConstants';

export const userSignIn = user => ({
  type: USER_SIGN_IN,
  user
});

export const userSignUp = user => ({
  type: USER_SIGN_UP,
  user
});

export const showMessage = (message) => ({
  type: MESSAGE,
  message
});

export const signIn = (data) => (dispatch) =>
  api.authentications.sign_in(data)
    .then(user => {
      localStorage.token = user.token.token;
      setAuthorizationHeader(user.token.token);
      dispatch(userSignIn(user))
});

export const signUp = (data) => (dispatch) =>
  api.authentications.sign_up(data)
    .then(user => {
      localStorage.token = user.token.token;
      setAuthorizationHeader(user.token.token);
      dispatch(userSignUp(user))
});

export const logout = () => (dispatch) =>
  api.authentications.logout().then(message => {
    dispatch(showMessage(message.data))
  }
);