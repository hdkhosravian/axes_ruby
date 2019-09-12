import React from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import { Route, Redirect } from 'react-router-dom';

const GuestRoute = ({isAuthenticated, component: Component, ...rest}) => (
  <Route {...rest} render={props => !isAuthenticated ? <Component {...props} /> : <Redirect to="/" />} />
);

GuestRoute.propTypes = {
  component: PropTypes.object.isRequired,
  isAuthenticated: PropTypes.bool.isRequired
}

function mapStateToProps(state) {
  return{
    isAuthenticated: !!state.authentications.token
  }
}

export default connect(mapStateToProps)(GuestRoute)
