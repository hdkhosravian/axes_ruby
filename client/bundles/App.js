import React from 'react';
import { Provider } from 'react-redux';
import { Route, Switch, Router} from "react-router-dom";
import { createBrowserHistory } from "history";

import configureStore from './store';

import GuestRoute from './routes/GuestRoute';
import UserRoute from './routes/UserRoute';

import LoginContainer from './Authentication/containers/LoginContainer';
import RegisterContainer from './Authentication/containers/RegisterContainer';
import DashboardContainer from './Dashboard/containers/DashboardContainer';

const hist = createBrowserHistory();

const App = (props) => (
  <Router history={hist}>
    <Provider store={configureStore(props)}>
      <Switch>
        <GuestRoute path="/login" exact component={LoginContainer}></GuestRoute>
        <GuestRoute path="/register" exact component={RegisterContainer}></GuestRoute>
        {/* you can add special route for your users like this: */}
        <UserRoute path="/" exact component={DashboardContainer}></UserRoute>
      </Switch>
    </Provider>
  </Router>
);

export default App;
