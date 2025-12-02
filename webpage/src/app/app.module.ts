import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent } from './app.component';
import { TicketsComponent } from './tickets/tickets.component';
import { KnowledgebaseComponent } from './knowledgebase/knowledgebase.component';
import { LogsComponent } from './logs/logs.component';

const routes: Routes = [
  { path: '', redirectTo: '/tickets', pathMatch: 'full' },
  { path: 'tickets', component: TicketsComponent },
  { path: 'knowledgebase', component: KnowledgebaseComponent },
  { path: 'logs', component: LogsComponent },
];

@NgModule({
  declarations: [
    AppComponent,
    TicketsComponent,
    KnowledgebaseComponent,
    LogsComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    RouterModule.forRoot(routes)
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
