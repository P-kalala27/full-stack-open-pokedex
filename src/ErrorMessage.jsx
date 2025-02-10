import React from 'react'

const ErrorMessage = ({ error }) => (
  <div data-testid="error">An error occured: {error.toString()} make a changige</div>
)

export default ErrorMessage
