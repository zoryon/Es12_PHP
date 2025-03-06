function main() {
    const params = new URLSearchParams(window.location.search);
    const nation = params.get("nation");

    if (!nation) {
        throw new Error("Bad request");
    }

    fetch("/Es12_PHP/api/nations.php?nation=" + nation, {
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

            const container = document.getElementById("nations-container");

            const title = document.createElement("h1");
            title.textContent = nation;

            container.appendChild(title);
            data.forEach(airport => {
                const div = document.createElement("div");
                
                Object.keys(airport).forEach(key => {
                    const p = document.createElement("p");
                    p.textContent = key + ": " + airport[key];
                    div.appendChild(p);
                });

                container.appendChild(div);
            });
        });
}

document.addEventListener("DOMContentLoaded", main);