import { connect } from 'react-redux';
import Login from '../components/Login';
import * as actions from '../actions/authenticationActions';

const mapStateToProps = (state) => ({});

export default connect(mapStateToProps, actions)(Login);
