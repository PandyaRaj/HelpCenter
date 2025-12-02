import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Internal Tools Dashboard';
  isSidebarOpen = false; // Start collapsed on mobile

  ngOnInit() {
    // Auto-expand sidebar on desktop, keep collapsed on mobile
    this.isSidebarOpen = window.innerWidth > 768;
  }

  toggleSidebar() {
    this.isSidebarOpen = !this.isSidebarOpen;
  }

  // Add this method to check if screen is mobile
  isMobile(): boolean {
    return window.innerWidth < 1024;
  }
}