"""
Build and verify the NCAA 2026 Tournament Starting Lineup Height Dataset.

Reads the raw CSV, recalculates average heights by position (G, F, C) for each team,
and outputs a clean summary CSV.
"""

import csv

def height_to_inches(h):
    """Convert height string like '6-4' to inches (76)."""
    feet, inches = h.split("-")
    return int(feet) * 12 + int(inches)

def inches_to_display(val):
    """Convert inches float to display string like 6'4.5\"."""
    feet = int(val) // 12
    inches = val - (feet * 12)
    return f"{feet}'{inches:.1f}\""

def main():
    teams = []

    with open("ncaa_2026_tournament_starting_lineup_heights.csv", "r") as f:
        reader = csv.DictReader(f)
        for row in reader:
            team = row["Team"]
            seed = row["Seed"]
            region = row["Region"]

            guards = []
            forwards = []
            centers = []

            for i in range(1, 6):
                pos = row[f"Player{i}_Pos"]
                height = row[f"Player{i}_Height"]
                h_inches = height_to_inches(height)

                if pos == "G":
                    guards.append(h_inches)
                elif pos == "F":
                    forwards.append(h_inches)
                elif pos == "C":
                    centers.append(h_inches)

            avg_g = sum(guards) / len(guards) if guards else None
            avg_f = sum(forwards) / len(forwards) if forwards else None
            avg_c = sum(centers) / len(centers) if centers else None

            teams.append({
                "Team": team,
                "Seed": seed,
                "Region": region,
                "Avg_G_Height_Inches": round(avg_g, 2) if avg_g else "",
                "Avg_F_Height_Inches": round(avg_f, 2) if avg_f else "",
                "Avg_C_Height_Inches": round(avg_c, 2) if avg_c else "",
                "Avg_G_Height": inches_to_display(avg_g) if avg_g else "",
                "Avg_F_Height": inches_to_display(avg_f) if avg_f else "",
                "Avg_C_Height": inches_to_display(avg_c) if avg_c else "",
                "Num_G": len(guards),
                "Num_F": len(forwards),
                "Num_C": len(centers),
            })

    # Write summary CSV
    fieldnames = [
        "Team", "Seed", "Region",
        "Avg_G_Height", "Avg_F_Height", "Avg_C_Height",
        "Avg_G_Height_Inches", "Avg_F_Height_Inches", "Avg_C_Height_Inches",
        "Num_G", "Num_F", "Num_C",
    ]
    with open("ncaa_2026_height_averages_by_position.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(teams)

    print(f"Processed {len(teams)} teams")
    print()

    # Print summary table
    print(f"{'Team':<25} {'Seed':>4} {'Region':<8} {'Avg G':>8} {'Avg F':>8} {'Avg C':>8} {'#G':>3} {'#F':>3} {'#C':>3}")
    print("-" * 85)
    for t in teams:
        print(f"{t['Team']:<25} {t['Seed']:>4} {t['Region']:<8} {t['Avg_G_Height']:>8} {t['Avg_F_Height']:>8} {t['Avg_C_Height']:>8} {t['Num_G']:>3} {t['Num_F']:>3} {t['Num_C']:>3}")

if __name__ == "__main__":
    main()
