import React from 'react'
import ReactDOM from 'react-dom';
import { Route, BrowserRouter } from 'react-router-dom';

import ReactDOM from 'react-dom'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <BrowserRouter>
      <Route path="/" component={App} />
    </BrowserRouter>,
    document.body.appendChild(document.createElement('div')),
  )
})
