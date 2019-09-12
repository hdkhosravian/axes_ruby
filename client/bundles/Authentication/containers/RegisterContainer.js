import { connect } from 'react-redux';
import Register from '../components/Register';
import * as actions from '../actions/authenticationActions';

const mapStateToProps = (state) => ({});

export default connect(mapStateToProps, actions)(Register);
