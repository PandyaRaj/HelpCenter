import { Component, OnInit } from '@angular/core';

interface Ticket {
  id: string;
  subject: string;
  status: 'Open' | 'In Progress' | 'Closed';
  createdAt: Date;
  priority: 'Low' | 'Medium' | 'High';
  assignee: string;
}

@Component({
  selector: 'app-tickets',
  templateUrl: './tickets.component.html',
  styleUrls: ['./tickets.component.css']
})
export class TicketsComponent implements OnInit {
  tickets: Ticket[] = [];
  filteredTickets: Ticket[] = [];
  selectedFilter: string = 'All';

  ngOnInit() {
    this.generateDummyTickets();
    this.filterTickets('All');
  }

  generateDummyTickets() {
    const subjects = [
      'Unable to login to dashboard',
      'Payment processing error',
      'Mobile app crash on startup',
      'Feature request: Dark mode',
      'Data export not working',
      'Email notifications delayed',
      'API rate limit too restrictive',
      'User profile image upload fails',
      'Search functionality broken',
      'Integration with Slack needed',
      'Performance issues on large datasets',
      'Security vulnerability report',
      'Documentation outdated',
      'Cannot reset password',
      'Billing discrepancy'
    ];

    const statuses: Array<'Open' | 'In Progress' | 'Closed'> = ['Open', 'In Progress', 'Closed'];
    const priorities: Array<'Low' | 'Medium' | 'High'> = ['Low', 'Medium', 'High'];
    const assignees = ['Alice Johnson', 'Bob Smith', 'Charlie Davis', 'Diana Prince', 'Unassigned'];

    this.tickets = subjects.map((subject, index) => ({
      id: `TKT-${1000 + index}`,
      subject,
      status: statuses[Math.floor(Math.random() * statuses.length)],
      createdAt: new Date(Date.now() - Math.random() * 30 * 24 * 60 * 60 * 1000),
      priority: priorities[Math.floor(Math.random() * priorities.length)],
      assignee: assignees[Math.floor(Math.random() * assignees.length)]
    }));
  }

  filterTickets(status: string) {
    this.selectedFilter = status;
    if (status === 'All') {
      this.filteredTickets = [...this.tickets];
    } else {
      this.filteredTickets = this.tickets.filter(t => t.status === status);
    }
  }

  getStatusColor(status: string): string {
    switch (status) {
      case 'Open': return 'bg-yellow-100 text-yellow-800 border-yellow-200';
      case 'In Progress': return 'bg-blue-100 text-blue-800 border-blue-200';
      case 'Closed': return 'bg-green-100 text-green-800 border-green-200';
      default: return 'bg-gray-100 text-gray-800 border-gray-200';
    }
  }

  getPriorityColor(priority: string): string {
    switch (priority) {
      case 'High': return 'text-red-600';
      case 'Medium': return 'text-orange-600';
      case 'Low': return 'text-green-600';
      default: return 'text-gray-600';
    }
  }

  formatDate(date: Date): string {
    const now = new Date();
    const diff = now.getTime() - date.getTime();
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    
    if (days === 0) return 'Today';
    if (days === 1) return 'Yesterday';
    if (days < 7) return `${days} days ago`;
    return date.toLocaleDateString();
  }

  get openCount(): number {
    return this.tickets.filter(t => t.status === 'Open').length;
  }

  get inProgressCount(): number {
    return this.tickets.filter(t => t.status === 'In Progress').length;
  }

  get closedCount(): number {
    return this.tickets.filter(t => t.status === 'Closed').length;
  }
}
