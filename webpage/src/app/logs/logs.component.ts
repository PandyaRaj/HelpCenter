import { Component, OnInit, OnDestroy, ViewChild, ElementRef } from '@angular/core';

interface LogEntry {
  id: number;
  timestamp: Date;
  level: 'INFO' | 'WARNING' | 'ERROR' | 'SUCCESS';
  message: string;
  source: string;
}

@Component({
  selector: 'app-logs',
  templateUrl: './logs.component.html',
  styleUrls: ['./logs.component.css']
})
export class LogsComponent implements OnInit, OnDestroy {
  @ViewChild('logContainer') logContainer!: ElementRef;
  
  logs: LogEntry[] = [];
  autoScroll: boolean = true;
  isPaused: boolean = false;
  private logInterval: any;
  private logIdCounter: number = 1;

  private logTemplates = [
    { level: 'INFO' as const, messages: [
      'User authentication successful',
      'Database connection established',
      'API request processed',
      'Cache updated successfully',
      'Background job completed',
      'Email notification sent',
      'File upload completed',
      'Session created',
      'Configuration loaded',
      'Service started'
    ], sources: ['AuthService', 'DatabaseService', 'APIGateway', 'CacheManager', 'JobScheduler']},
    
    { level: 'SUCCESS' as const, messages: [
      'Payment processed successfully',
      'Data backup completed',
      'Migration executed successfully',
      'Report generated',
      'Integration test passed'
    ], sources: ['PaymentService', 'BackupService', 'MigrationService', 'ReportService', 'TestRunner']},
    
    { level: 'WARNING' as const, messages: [
      'API rate limit approaching',
      'Memory usage above 80%',
      'Slow query detected',
      'Deprecated API endpoint accessed',
      'SSL certificate expiring soon',
      'Disk space running low',
      'Connection timeout increased'
    ], sources: ['RateLimiter', 'SystemMonitor', 'DatabaseMonitor', 'APIGateway', 'SecurityService']},
    
    { level: 'ERROR' as const, messages: [
      'Failed to connect to external service',
      'Invalid request parameters',
      'Database query timeout',
      'Authentication failed',
      'File not found',
      'Permission denied',
      'Network connection lost'
    ], sources: ['ExternalService', 'Validator', 'DatabaseService', 'AuthService', 'FileService']}
  ];

  ngOnInit() {
    this.generateInitialLogs();
    this.startLogGeneration();
  }

  ngOnDestroy() {
    if (this.logInterval) {
      clearInterval(this.logInterval);
    }
  }

  generateInitialLogs() {
    for (let i = 0; i < 10; i++) {
      this.addRandomLog();
    }
  }

  startLogGeneration() {
    this.logInterval = setInterval(() => {
      if (!this.isPaused) {
        this.addRandomLog();
        if (this.autoScroll) {
          setTimeout(() => this.scrollToBottom(), 100);
        }
      }
    }, 2000); // Generate new log every 2 seconds
  }

  addRandomLog() {
    const template = this.logTemplates[Math.floor(Math.random() * this.logTemplates.length)];
    const message = template.messages[Math.floor(Math.random() * template.messages.length)];
    const source = template.sources[Math.floor(Math.random() * template.sources.length)];

    const newLog: LogEntry = {
      id: this.logIdCounter++,
      timestamp: new Date(),
      level: template.level,
      message,
      source
    };

    this.logs.unshift(newLog);
    
    // Keep only last 100 logs
    if (this.logs.length > 100) {
      this.logs.pop();
    }
  }

  togglePause() {
    this.isPaused = !this.isPaused;
  }

  toggleAutoScroll() {
    this.autoScroll = !this.autoScroll;
    if (this.autoScroll) {
      this.scrollToBottom();
    }
  }

  clearLogs() {
    if (confirm('Are you sure you want to clear all logs?')) {
      this.logs = [];
    }
  }

  scrollToBottom() {
    try {
      if (this.logContainer) {
        this.logContainer.nativeElement.scrollTop = 0;
      }
    } catch (err) {
      console.error('Error scrolling:', err);
    }
  }

  getLevelColor(level: string): string {
    switch (level) {
      case 'INFO': return 'text-blue-600 bg-blue-50 border-blue-200';
      case 'SUCCESS': return 'text-green-600 bg-green-50 border-green-200';
      case 'WARNING': return 'text-orange-600 bg-orange-50 border-orange-200';
      case 'ERROR': return 'text-red-600 bg-red-50 border-red-200';
      default: return 'text-gray-600 bg-gray-50 border-gray-200';
    }
  }

  getLevelIcon(level: string): string {
    switch (level) {
      case 'INFO': return 'ℹ️';
      case 'SUCCESS': return '✅';
      case 'WARNING': return '⚠️';
      case 'ERROR': return '❌';
      default: return '📝';
    }
  }

  formatTime(date: Date): string {
    return date.toLocaleTimeString();
  }

  exportLogs() {
    const logText = this.logs.map(log => 
      `[${this.formatTime(log.timestamp)}] [${log.level}] [${log.source}] ${log.message}`
    ).join('\n');
    
    const blob = new Blob([logText], { type: 'text/plain' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `logs_${new Date().getTime()}.txt`;
    a.click();
    window.URL.revokeObjectURL(url);
  }

  get successCount(): number {
    return this.logs.filter(l => l.level === 'SUCCESS').length;
  }

  get warningCount(): number {
    return this.logs.filter(l => l.level === 'WARNING').length;
  }

  get errorCount(): number {
    return this.logs.filter(l => l.level === 'ERROR').length;
  }
}
