// import timeago from 'timeago.js';
// const timeagoInstance = timeago();

// const helpers = {};

// helpers.timeago = (savedTimestamp) => {
//     return timeagoInstance.format(savedTimestamp);
// };

// export default helpers;

import { format } from "timeago.js";

// función para obtener una fecha en formato legible
export const timeago = (timestamp) => {
  const date = new Date(timestamp);
  const options = { locale: "es" }; // indicamos que queremos el formato en español
  return format(date, options); // retornamos la fecha formateada
};

export const formatDate = (dateString) => {
  const date = new Date(dateString);
  return date.toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' });
};

export const formatAmount=(amount) =>{
  const formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  });

  return formatter.format(amount);
}