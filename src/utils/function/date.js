export function formatDateToLocalISO(date) {
    const dateObj = new Date(date);

    if (isNaN(dateObj.getTime())) {
      throw new Error("Invalid date");
    }

    const year = dateObj.getFullYear();
    const month = String(dateObj.getMonth() + 1).padStart(2, "0");
    const day = String(dateObj.getDate()).padStart(2, "0");

    return `${year}-${month}-${day}`;
  }

 