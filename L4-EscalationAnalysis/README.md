# L4 IT Support Escalation Analysis Dashboard

## Project Overview
This project analyzes escalated IT support tickets from L1/L2 Service Desk teams to an L4 AppOps team, focusing on SaaS application license and access issues. It mirrors a real business problem I worked on professionally, rebuilt here end-to-end using **synthetic data** for a public portfolio. The goal: identify why tickets get escalated, and design a data-backed process change to reduce unnecessary escalations.

## Business Problem
The L4 AppOps team was receiving frequent escalations for license/access issues across multiple SaaS apps (Adobe, Figma, Asana, Smartsheet, Zoom, and others). Many of these escalations were avoidable, caused by:
- **Knowledge gaps** at L1/L2 level (missing SOPs/KB articles)
- **Admin access limitations** (L1/L2 lacked permissions to resolve issues themselves)
- Legitimate policy exceptions or technical bugs (not preventable)

This consumed L4 capacity that could otherwise go toward strategic work — license cost optimization, application enhancements, and access governance.

## Objective
Build an interactive dashboard and process redesign to:
1. Track escalation volume, SLA performance, and resolution times
2. Identify which apps and escalation reasons drive the most tickets
3. Distinguish *preventable* escalations (fixable via training/access design) from ones requiring genuine L4 involvement
4. Propose a TO-BE process that shifts resolution capability down to L2, freeing L4 time

## Data Source
- **Source system (modeled on):** ServiceNow
- **Teams:** L1 Service Desk, L2 Service Desk, L4 AppOps
- **Apps covered:** Adobe, Appspace, Figma, Smartsheet, Lucidchart, Mural, Box, Asana, Zoom
- **Time period:** Jan 2024 – Oct 2024
- **Records:** 100 escalated tickets (fully synthetic, built for this portfolio piece)

## Methodology

### 1. Data Preparation (Excel / SQLite)
- Structured ticket data with key fields: Ticket ID, Date, App, Priority, Source Team, Escalation Reason, SLA Status, Resolution Time, CSAT
- Cleaned and loaded into SQLite (`escalation_tickets.db`) for querying

### 2. Data Analysis (SQL)
Wrote and verified 8 queries covering:
- Overall SLA performance
- Top problem areas (App + Escalation Reason combinations)
- Monthly escalation trend
- Escalation reason breakdown
- Resolution time by priority
- App-level escalation volume
- L1 vs. L2 escalation source split
- Preventable vs. non-preventable escalation categorization

See `sql_queries.sql` for all queries — every query in this file has been run against the actual dataset and returns verified results.

### 3. Visualization (Tableau)
Built an interactive dashboard (`Escalations.twb`) with:
- **KPI cards:** Total escalations, average SLA %, top app by volume
- **Charts:** Escalation reason breakdown, monthly SLA trend, ticket volume by app
- Screenshots of the dashboard are in `/images`

### 4. Process Redesign (AS-IS / TO-BE Swimlane Diagrams)
Mapped the current escalation workflow and a proposed redesign — see `/diagrams`.

## Key Findings *(verified against the dataset — see `sql_queries.sql`)*

**Escalation Reason Breakdown:**
- **29% Admin Access Gap** — L1/L2 lack permissions to resolve; access-design fix
- **24% Bug/Technical Issue** — genuine L4 complexity, not preventable
- **24% Policy Exception** — governance-driven, requires L4 approval
- **23% Knowledge Gap** — L4 resolves but doesn't document; training/KB opportunity

**Top Apps by Escalation Volume:**
- Zoom (17%), Box (13%), Appspace (12%) drive the most tickets

**Overall Performance:**
- 96% of tickets met SLA overall, with a dip in specific months (see monthly trend)
- Average resolution time varies significantly by priority tier
- **52% of escalations are preventable** (Admin Access Gap + Knowledge Gap combined) through better access design and documentation
- Escalation source split: **55% from L2, 45% from L1**

## Recommendations
1. **Access Redesign:** Extend delegated admin permissions to L2 for routine, low-risk actions (e.g., Zoom license/permission resets) — directly targets the 29% Admin Access Gap
2. **Knowledge Transfer Process:** Require L4 to create a KB article and run a short KT session after resolving any escalation caused by a knowledge gap — targets the 23% Knowledge Gap category
3. **App-Specific Runbook:** Build a dedicated Zoom troubleshooting runbook given its outsized share of ticket volume
4. **Monitoring:** Track escalation volume monthly post-implementation to validate whether the process change actually reduces preventable escalations

*Note: this is a portfolio project built on synthetic data to demonstrate methodology, not a report of already-achieved results at a real employer. Any specific reduction percentage would need to be validated after implementation, not assumed in advance.*

## Tools Used
- **Data processing:** SQLite, Excel
- **Analysis:** SQL (aggregations, grouping, calculated categorization)
- **Visualization:** Tableau
- **Process mapping:** Lucidchart (AS-IS / TO-BE swimlane diagrams)
- **Documentation:** Business Requirements Document (BRD), Case Study write-up

## Repository Structure
```
├── README.md                          — this file
├── data/
│   ├── escalation_tickets.db          — SQLite database (100 synthetic tickets)
│   ├── escalation_tickets_fixed.csv   — raw ticket-level data
│   ├── monthly_sla.csv                — pre-aggregated monthly summary
│   └── top_problems.csv               — pre-aggregated escalation reason summary
├── sql_queries.sql                    — all 8 analysis queries, verified against the data
├── dashboard/
│   └── Escalations.twb                — Tableau workbook
├── diagrams/
│   ├── AS-IS-Swimlane.jpg
│   └── TO-BE-Swimlane.jpg
├── docs/
│   ├── L4-Knowledge-Transfer-Solution-BRD.docx
│   └── L4-Escalations-Case-Study.docx
└── images/
    └── dashboard screenshots
```

## How to Use
1. Open `data/escalation_tickets.db` in any SQLite client (e.g., DB Browser for SQLite)
2. Run queries from `sql_queries.sql` to reproduce the analysis
3. Open `dashboard/Escalations.twb` in Tableau (Public or Desktop) to explore the interactive dashboard
4. Review `diagrams/` for the AS-IS vs. TO-BE process redesign

## Skills Demonstrated
- Business problem framing and root-cause analysis
- SQL query writing (aggregation, grouping, calculated fields)
- Dashboard design and data visualization (Tableau)
- Process mapping (AS-IS / TO-BE swimlane diagrams)
- Business Requirements Document (BRD) authoring
- IT service management workflows (ServiceNow-modeled: L1/L2/L4 escalation tiers)

## Author
**Suhasini Pillay**
MSc Business Analytics, University College Cork
[LinkedIn](https://linkedin.com/in/suhasini-pillay-b9a644196) | [GitHub](https://github.com/Suhasini1011) | [Email](mailto:pillaysuhasini346@gmail.com)

---
*This is a personal portfolio project built with synthetic data to demonstrate an end-to-end analytics workflow — from problem framing through SQL analysis, dashboard design, and process documentation.*
