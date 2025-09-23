/**
 * Acadify Theme Management
 * Handles dark/light mode switching with system detection
 */

class ThemeManager {
    constructor() {
        this.init();
    }

    init() {
        // Check for saved theme preference or default to 'auto'
        const savedTheme = localStorage.getItem('acadify-theme') || 'auto';
        this.setTheme(savedTheme);
        
        // Listen for system theme changes
        window.matchMedia('(prefers-color-scheme: dark)').addListener(e => {
            if (localStorage.getItem('acadify-theme') === 'auto') {
                this.applyTheme(e.matches ? 'dark' : 'light');
            }
        });

        // Setup theme toggle buttons
        this.setupThemeToggles();
    }

    setTheme(theme) {
        localStorage.setItem('acadify-theme', theme);
        
        if (theme === 'auto') {
            const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
            this.applyTheme(systemTheme);
        } else {
            this.applyTheme(theme);
        }
        
        // Update theme toggle button state
        this.updateThemeToggleState(theme);
    }

    applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        
        // Update theme icon
        const themeIcon = document.getElementById('theme-icon');
        if (themeIcon) {
            themeIcon.textContent = theme === 'dark' ? '☀️' : '🌙';
        }
        
        // Send theme to server if user is logged in
        if (typeof fetch !== 'undefined') {
            fetch('/api/toggle-theme', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ theme })
            }).catch(err => console.log('Theme sync failed:', err));
        }
    }

    updateThemeToggleState(currentTheme) {
        const toggleBtn = document.getElementById('theme-toggle');
        if (toggleBtn) {
            toggleBtn.setAttribute('data-theme', currentTheme);
            toggleBtn.title = `Current theme: ${currentTheme}`;
        }
    }

    setupThemeToggles() {
        // Main theme toggle button
        const themeToggle = document.getElementById('theme-toggle');
        if (themeToggle) {
            themeToggle.addEventListener('click', () => {
                const currentTheme = localStorage.getItem('acadify-theme') || 'auto';
                const nextTheme = currentTheme === 'light' ? 'dark' : 
                                currentTheme === 'dark' ? 'auto' : 'light';
                this.setTheme(nextTheme);
            });
        }

        // Theme dropdown options
        document.querySelectorAll('[data-theme-option]').forEach(option => {
            option.addEventListener('click', (e) => {
                e.preventDefault();
                const theme = option.getAttribute('data-theme-option');
                this.setTheme(theme);
            });
        });
    }

    getCurrentTheme() {
        return localStorage.getItem('acadify-theme') || 'auto';
    }

    getAppliedTheme() {
        return document.documentElement.getAttribute('data-theme') || 'light';
    }
}

// Password toggle functionality
function setupPasswordToggles() {
    document.querySelectorAll('.password-toggle').forEach(toggle => {
        toggle.addEventListener('click', function() {
            const passwordField = this.previousElementSibling;
            const icon = this.querySelector('span') || this;
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                icon.textContent = '👁️';
                this.setAttribute('aria-label', 'Hide password');
            } else {
                passwordField.type = 'password';
                icon.textContent = '👁️‍🗨️';
                this.setAttribute('aria-label', 'Show password');
            }
        });
    });
}

// Demo account functionality
function setupDemoAccounts() {
    document.querySelectorAll('.demo-use-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const account = this.closest('.demo-account');
            const username = account.querySelector('.demo-credentials').textContent.split(' / ')[0];
            const password = account.querySelector('.demo-credentials').textContent.split(' / ')[1];
            
            // Fill in the login form
            const usernameField = document.getElementById('username');
            const passwordField = document.getElementById('password');
            
            if (usernameField && passwordField) {
                usernameField.value = username;
                passwordField.value = password;
                
                // Add visual feedback
                usernameField.style.borderColor = '#10b981';
                passwordField.style.borderColor = '#10b981';
                
                setTimeout(() => {
                    usernameField.style.borderColor = '';
                    passwordField.style.borderColor = '';
                }, 2000);
            }
        });
    });
}

// Navbar mobile toggle
function setupMobileNavigation() {
    const mobileToggle = document.getElementById('mobile-nav-toggle');
    const mobileNav = document.getElementById('mobile-nav');
    
    if (mobileToggle && mobileNav) {
        mobileToggle.addEventListener('click', () => {
            mobileNav.classList.toggle('show');
        });
    }
}

// Flash message auto-dismiss
function setupFlashMessages() {
    document.querySelectorAll('.alert').forEach(alert => {
        // Auto-dismiss after 5 seconds
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            setTimeout(() => alert.remove(), 300);
        }, 5000);
        
        // Manual dismiss button
        const dismissBtn = alert.querySelector('.alert-dismiss');
        if (dismissBtn) {
            dismissBtn.addEventListener('click', () => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-10px)';
                setTimeout(() => alert.remove(), 300);
            });
        }
    });
}

// Form validation helpers
function setupFormValidation() {
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            const requiredFields = form.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    field.style.borderColor = '#ef4444';
                    isValid = false;
                } else {
                    field.style.borderColor = '';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
    });
}

// Initialize everything when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Initialize theme manager
    window.themeManager = new ThemeManager();
    
    // Setup all interactive features
    setupPasswordToggles();
    setupDemoAccounts();
    setupMobileNavigation();
    setupFlashMessages();
    setupFormValidation();
    
    // Add fade-in animation to main content
    document.querySelectorAll('.fade-in').forEach(element => {
        element.style.animation = 'fadeIn 0.5s ease-out';
    });
});

// Export for use in other scripts
window.AcadifyTheme = {
    ThemeManager,
    setupPasswordToggles,
    setupDemoAccounts,
    setupMobileNavigation,
    setupFlashMessages,
    setupFormValidation
};