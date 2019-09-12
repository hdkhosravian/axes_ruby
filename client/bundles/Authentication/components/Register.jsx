import React from "react";

// reactstrap components
import {
  Alert
} from "reactstrap";

class Register extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      // register form
      email: "",
      password: "",
      confirmPassword: "",
      acceptConditions: true,
      emailState: "",
      passwordState: "",
      visible: true,
      errors: {},
    };

    this.onDismiss = this.onDismiss.bind(this);
  }

  componentDidMount() {
    document.body.classList.toggle("register-page");
  }

  componentWillUnmount() {
    document.body.classList.toggle("register-page");
  }

  // function that returns true if value is email, false otherwise
  verifyEmail = value => {
    var emailRex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (emailRex.test(value)) {
      return true;
    }
    return false;
  };

  // function that verifies if a string has a given length or not
  verifyLength = (value, length) => {
    if (value.length >= length) {
      return true;
    }
    return false;
  };

  // function that verifies if two strings are equal
  compare = (string1, string2) => {
    if (string1 === string2) {
      return true;
    }
    return false;
  };

  change = (event, stateName, type, stateNameEqualTo, maxValue) => {
    switch (type) {
      case "email":
        if (this.verifyEmail(event.target.value)) {
          this.setState({ [stateName + "State"]: "has-success" });
        } else {
          this.setState({ [stateName + "State"]: "has-danger" });
        }
        break;
      case "password":
        if (this.verifyLength(event.target.value, 8)) {
          this.setState({ [stateName + "State"]: "has-success" });
        } else {
          this.setState({ [stateName + "State"]: "has-danger" });
        }
        
        if (this.compare(event.target.value, this.state[stateNameEqualTo])) {
          this.setState({ [stateNameEqualTo + "State"]: "has-success" });
        } else {
          this.setState({ [stateNameEqualTo + "State"]: "has-danger" });
        }
        break;
      case "equalTo":
        if (this.compare(event.target.value, this.state[stateNameEqualTo])) {
          this.setState({ [stateName + "State"]: "has-success" });
        } else {
          this.setState({ [stateName + "State"]: "has-danger" });
        }
        break;
      default:
        break;
    }
    this.setState({ [stateName]: event.target.value });
  };

  registerClick = () => {
    if (this.state.emailState === "") {
      this.setState({ emailState: "has-danger" });
    }
    if (
      this.state.passwordState === "" ||
      this.state.confirmPasswordState === ""
    ) {
      this.setState({ passwordState: "has-danger" });
      this.setState({ confirmPasswordState: "has-danger" });
    }

    if(this.state.acceptConditions && this.checkValues("has-success")){
      console.log('SignUp is processing')
      this.submit()
    }
  };

  submit = () => {
    const data = {
      email: this.state.email,
      password: this.state.password,
      confirm_password: this.state.confirmPassword
    }

    this.props
      .signUp(data)
      .then(() => {
        // if everything was ok you can do anything that you want, for example:
        // this.props.history.push("/") go to the dashboard
      })
      .catch(err => {
        const error = err.response ? err.response.data : err.message;
        this.setState({ errors: { response: error.response[0] }, visible: true });
      });
  }

  checkValues = (value) => {
    return [
      this.state.emailState,
      this.state.passwordState,
      this.state.confirmPasswordState
    ].every(
      function(v, i, array){
        return array[i] === value;
      }
    )
  }

  onDismiss() {
    this.setState({ visible: false });
  }

  showErrorResponse = (message) => {
    return (
      <div>
        <Alert
          place={'tc'}
          color="danger"
          isOpen={this.state.visible}
          toggle={this.onDismiss}
        >
          <span>{message}</span>
        </Alert>
      </div>
    )
  }

  render() {
    // taking all the states
    let {
      errors
    } = this.state;

    return (
      <div>
        {
          errors.response &&
          this.showErrorResponse(errors.response)
        }
        <p>
          Register
        </p>
      </div>
    );
  }
}

export default Register;
