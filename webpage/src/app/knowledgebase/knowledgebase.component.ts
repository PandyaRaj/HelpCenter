import { Component, OnInit } from '@angular/core';
import { marked } from 'marked';

@Component({
  selector: 'app-knowledgebase',
  templateUrl: './knowledgebase.component.html',
  styleUrls: ['./knowledgebase.component.css']
})
export class KnowledgebaseComponent implements OnInit {
  markdownContent: string = `# Getting Started Guide

## Introduction
Welcome to our Internal Tools Dashboard! This guide will help you get started with the system.

## Quick Start
1. **Login**: Use your company credentials
2. **Navigate**: Use the sidebar to access different modules
3. **Create Tickets**: Report issues or request features

## Features

### Ticket Management
- Create and track support tickets
- Filter by status (Open, In Progress, Closed)
- Assign tickets to team members
- Set priority levels

### Knowledge Base
- Create and edit documentation
- Use Markdown for formatting
- Preview changes in real-time
- Save articles for team reference

### Live Logs
- Monitor system events in real-time
- Filter logs by type
- Auto-scroll to latest entries

## Markdown Syntax

### Headers
\`\`\`
# H1 Header
## H2 Header
### H3 Header
\`\`\`

### Lists
- Bullet point 1
- Bullet point 2
  - Nested item

1. Numbered item 1
2. Numbered item 2

### Formatting
**Bold text** and *italic text*

### Code
\`inline code\` or code blocks:

\`\`\`javascript
function hello() {
  console.log('Hello World!');
}
\`\`\`

## Need Help?
Contact the support team at support@company.com
`;

  previewHtml: string = '';
  showPreview: boolean = true;
  saveMessage: string = '';

  ngOnInit() {
    this.updatePreview();
  }

  updatePreview() {
    this.previewHtml = marked.parse(this.markdownContent) as string;
  }

  togglePreview() {
    this.showPreview = !this.showPreview;
  }

  saveContent() {
    // Simulate saving
    this.saveMessage = 'Content saved successfully!';
    setTimeout(() => {
      this.saveMessage = '';
    }, 3000);
  }

  clearContent() {
    if (confirm('Are you sure you want to clear all content?')) {
      this.markdownContent = '';
      this.updatePreview();
    }
  }

  insertTemplate() {
    const template = `
## New Article Title

### Overview
Provide a brief overview of the topic.

### Step-by-Step Instructions
1. First step
2. Second step
3. Third step

### Troubleshooting
- **Issue**: Description
- **Solution**: How to fix

### Additional Resources
- [Link 1](#)
- [Link 2](#)
`;
    this.markdownContent += template;
    this.updatePreview();
  }
}
