"""
Build and verify the NCAA 2026 Tournament Starting Lineup Age Dataset.

Reads the raw age CSV, recalculates average team age, and outputs a clean summary CSV.
"""

import csv


def main():
    teams = []

    with open("ncaa_2026_tournament_starting_lineup_ages.csv", "r") as f:
        reader = csv.DictReader(f)
        for row in reader:
            team = row["Team"]
            seed = row["Seed"]
            region = row["Region"]

            ages = []
            for i in range(1, 6):
                age = int(row[f"Player{i}_Age"])
                ages.append(age)

            avg_age = sum(ages) / len(ages)

            teams.append({
                "Team": team,
                "Seed": seed,
                "Region": region,
                "Avg_Team_Age": round(avg_age, 1),
                "Youngest_Starter": min(ages),
                "Oldest_Starter": max(ages),
            })

    # Write summary CSV
    fieldnames = ["Team", "Seed", "Region", "Avg_Team_Age", "Youngest_Starter", "Oldest_Starter"]
    with open("ncaa_2026_age_averages.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(teams)

    print(f"Processed {len(teams)} teams")
    print()

    # Sort by avg age for interesting display
    teams_sorted = sorted(teams, key=lambda t: t["Avg_Team_Age"])

    print(f"{'Team':<25} {'Seed':>4} {'Region':<8} {'Avg Age':>8} {'Young':>6} {'Old':>4}")
    print("-" * 60)
    for t in teams_sorted:
        print(f"{t['Team']:<25} {t['Seed']:>4} {t['Region']:<8} {t['Avg_Team_Age']:>8} {t['Youngest_Starter']:>6} {t['Oldest_Starter']:>4}")

    print()
    avg_all = sum(t["Avg_Team_Age"] for t in teams) / len(teams)
    print(f"Tournament-wide average starter age: {avg_all:.1f}")
    print(f"Youngest team: {teams_sorted[0]['Team']} ({teams_sorted[0]['Avg_Team_Age']})")
    print(f"Oldest team: {teams_sorted[-1]['Team']} ({teams_sorted[-1]['Avg_Team_Age']})")


if __name__ == "__main__":
    main()
