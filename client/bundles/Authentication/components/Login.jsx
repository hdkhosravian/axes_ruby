import React from "react";

// reactstrap components
import {
  Alert
} from "reactstrap";

class Login extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      // login form
      email: "",
      password: "",
      emailState: "",
      passwordState: "",
      visible: true,
      errors: {},
    };

    this.onDismiss = this.onDismiss.bind(this);
  }

  componentDidMount() {
    document.body.classList.toggle("login-page");
  }

  componentWillUnmount() {
    document.body.classList.toggle("login-page");
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
        break;
      default:
        break;
    }

    this.setState({ 
      [stateName]: event.target.value
    });
  };

  loginClick = () => {
    if (this.state.emailState === "") {
      this.setState({ emailState: "has-danger" });
    }
    if (this.state.passwordState === "") {
      this.setState({ passwordState: "has-danger" });
    }

    if(this.checkValues("has-success")){
      this.submit()
    }
  };

  submit = () => {
    const data = {
      email: this.state.email,
      password: this.state.password
    }

    this.props
      .signIn(data)
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
          Login
        </p>
      </div>
    );
  }
}

export default Login;
