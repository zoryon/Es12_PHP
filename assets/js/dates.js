function main() {
    const params = new URLSearchParams(window.location.search);
    const date = params.get("date");

    if (!date) {
        throw new Error("Bad request");
    }

    fetch("/Es12_PHP/api/dates.php?date=" + date, {
        method: "GET",
        headers: {
            "Accept": "application/json"
        }
    })
        .then(res => {
            if (!res.ok) {
                throw new Error("Errore nella richiesta HTTP");
            }
            return res.json();
        })
        .then(data => {
            console.log(data);

            const container = document.getElementById("flights-container");

            const title = document.createElement("h1");
            title.textContent = date;

            container.appendChild(title);

            data.forEach(flight => {
                const div = document.createElement("div");
                
                Object.keys(flight).forEach(key => {
                    const p = document.createElement("p");
                    p.textContent = key + ": " + flight[key];
                    div.appendChild(p);
                });

                container.appendChild(div);
            });
        });
}

document.addEventListener("DOMContentLoaded", main);