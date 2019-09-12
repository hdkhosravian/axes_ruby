import { USER_SIGN_IN, USER_SIGN_UP } from '../constants/authenticationConstants';

export default function authentications(state = {}, action = {}) {
  switch (action.type) {
    case USER_SIGN_IN:
      return action.user;
    case USER_SIGN_UP:
      return action.user;
    default:
      return state;
  }
};

