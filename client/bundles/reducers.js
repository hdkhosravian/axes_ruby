import { combineReducers } from 'redux';
import authentications from './Authentication/reducers/authenticationReducer'

const reducers = combineReducers({ authentications });

export default reducers;
