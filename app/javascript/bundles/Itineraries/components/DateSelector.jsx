import React, { Component } from 'react'
import DatePicker from 'react-datepicker'


class DateSelector extends Component {
  state = { startDate: new Date() }
  handleChange = date => {
    this.setState({ startDate: date })
    this.props.selectDate(date)
  }

  render() {
    return (
      <div className="dateSelecting">
      <DatePicker className="form-control"
        selected={this.state.startDate}
        onChange={this.handleChange}
      />
      </div>
    )
  }
}

export default DateSelector;
