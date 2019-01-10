import React, { Component } from 'react';
import DateSelector from './DateSelector'


class Search extends Component {
  state = { value: '' }
  handleSubmit = event => {
    event.preventDefault()
    const { value } = this.state
    this.props.handleSearch(value)
    this.setState({value: ''})
  }

  handleChange = event => {
    let { value } = this.state
    value = event.target.value
    this.setState({ value })
  }
  render() {
    const { value } = this.state
    return (
    
        <div class="search-box">
          <h1 className="hero-title">Find A Roadtrip Near You</h1>
          <form className="form-inline md-form mb-4" onSubmit={this.handleSubmit}>

            <div className="spacerForm">
              <input className="form-control mr-sm-2"
              id="search"
              type="text"
              aria-label="Search"
              placeholder="City"
              value={value}
              onChange={this.handleChange}
              />
              
              <button className="forms_buttons-action btn aqua-gradient btn-rounded btn-sm"
              type="submit" value="Search!">Search</button>
              </div>
          </form>
          </div>

    )
  }
}

export default Search;
