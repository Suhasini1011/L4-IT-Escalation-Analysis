-- ============================================================
-- L4 IT Support Escalation Analysis — SQL Queries
-- Database: escalation_tickets.db (SQLite)
-- Table: escalation_tickets_fixed (100 synthetic ticket records)
-- Author: Suhasini Pillay
-- ============================================================

-- 1. Overall SLA performance
SELECT
    COUNT(*) AS total_tickets,
    SUM(SLA_Met_Binary) AS sla_met_count,
    ROUND(100.0 * SUM(SLA_Met_Binary) / COUNT(*), 1) AS sla_met_pct
FROM escalation_tickets_fixed;

-- 2. Top problem areas: App + Escalation Reason combinations
SELECT
    App,
    EscalationReason,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM escalation_tickets_fixed), 1) AS pct_of_total
FROM escalation_tickets_fixed
GROUP BY App, EscalationReason
ORDER BY ticket_count DESC
LIMIT 10;

-- 3. Monthly escalation trend
SELECT
    Month,
    COUNT(*) AS ticket_count,
    ROUND(AVG(Resolution_Time_Hrs), 1) AS avg_resolution_hrs,
    ROUND(100.0 * SUM(SLA_Met_Binary) / COUNT(*), 1) AS sla_met_pct
FROM escalation_tickets_fixed
GROUP BY Month
ORDER BY Month;

-- 4. Escalation reason breakdown (Knowledge Gap vs Admin Access Gap vs others)
SELECT
    EscalationReason,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM escalation_tickets_fixed), 1) AS pct_of_total,
    ROUND(AVG(Resolution_Time_Hrs), 1) AS avg_resolution_hrs
FROM escalation_tickets_fixed
GROUP BY EscalationReason
ORDER BY ticket_count DESC;

-- 5. Resolution time patterns by priority
SELECT
    Priority,
    COUNT(*) AS ticket_count,
    ROUND(AVG(Resolution_Time_Hrs), 1) AS avg_resolution_hrs,
    ROUND(100.0 * SUM(SLA_Met_Binary) / COUNT(*), 1) AS sla_met_pct
FROM escalation_tickets_fixed
GROUP BY Priority
ORDER BY avg_resolution_hrs DESC;

-- 6. App-level escalation volume (verified: Zoom = 17%, not 42% — corrected from earlier draft)
SELECT
    App,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM escalation_tickets_fixed), 1) AS pct_of_total
FROM escalation_tickets_fixed
GROUP BY App
ORDER BY ticket_count DESC;

-- 7. L1 vs L2 escalation source split
SELECT
    SourceTeam,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM escalation_tickets_fixed), 1) AS pct_of_total
FROM escalation_tickets_fixed
GROUP BY SourceTeam
ORDER BY ticket_count DESC;

-- 8. Preventable vs non-preventable escalations
-- (Admin Access Gap + Knowledge Gap = preventable with better SOPs/access design;
--  Policy Exception + Bug/Technical Issue = requires L4 involvement regardless)
SELECT
    CASE
        WHEN EscalationReason IN ('Admin Access Gap', 'Knowledge Gap') THEN 'Preventable'
        ELSE 'Not Preventable (Governance/Technical)'
    END AS category,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM escalation_tickets_fixed), 1) AS pct_of_total
FROM escalation_tickets_fixed
GROUP BY category;
