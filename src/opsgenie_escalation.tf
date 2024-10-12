# ==================================================================
# CREATE OPSGENIE ESCALATION
# ==================================================================

resource "opsgenie_escalation" "this" {
  name          = "escalation-team-secops-cleartech"
  owner_team_id = opsgenie_team.this.id
  rules {
    condition   = "if-not-acked"
    notify_type = "users"
    delay       = 30
    recipient {
      type = "team"
      id   = opsgenie_team.this.id
    }
  }
  rules {
    condition   = "if-not-acked"
    notify_type = "admins"
    delay       = 60
    recipient {
      type = "team"
      id   = opsgenie_team.this.id
    }
  }
}
