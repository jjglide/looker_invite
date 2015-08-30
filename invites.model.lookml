- connection: invites_database

- scoping: true           # for backward compatibility
- include: "*.view"       # include all views in this project
- include: "*.dashboard"  # include all dashboards in this project



- base_view: invite
  persist_for: 8 hours
  
- base_view: profiles
  
  
