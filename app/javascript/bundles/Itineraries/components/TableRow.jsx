import React from 'react'

const TableRow = ({itinerary}) => (
  <tr>
    <td>
      {itinerary.start_date}
    </td>
    <td>
      {itinerary.end_date}
    </td>
    <td>
      {itinerary.available_seat}
    </td>
    <td>
      {itinerary.eta}
    </td>
    <td>
      {itinerary.start_loc}
    </td>
    <td>
      {itinerary.end_loc}
    </td>
    <td>
      {itinerary.description}
    </td>
    <td>
      {itinerary.user.username}
    </td>
  </tr>
)

export default TableRow
