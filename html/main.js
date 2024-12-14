document.addEventListener('DOMContentLoaded', () => {
    const killfeedContainer = document.querySelector('.killfeed-container');
    function addKillfeedEntry(killerName, victimName) {
        const killfeedEntry = document.createElement('div');
        killfeedEntry.classList.add('killfeed-entry'); 
        killfeedEntry.innerHTML = `
            <div class="name-container">
                <div class="killer-name">${killerName || 'Unknown'}</div>
            </div>
            <div class="icons">
                <img src="svg/gun.svg" alt="Weapon Icon" class="weapon-icon">
                <img src="svg/target.svg" alt="Target Icon" class="target-icon">
            </div>
            <div class="victim-name">${victimName || 'Unknown'}</div>
        `;
        killfeedContainer.appendChild(killfeedEntry);

        // Automatically remove the entry after 5 seconds
        setTimeout(() => {
            killfeedEntry.classList.add('fade-out'); 
            setTimeout(() => killfeedEntry.remove(), 500); 
        }, 5000);
    }

    // Listen for NUI messages
    window.addEventListener('message', (event) => {
        const { type, killer, victim } = event.data;

        if (type === 'updateKillfeed') {
            addKillfeedEntry(killer, victim);
        }
    });
});
