//
//  LabReportView.swift
//  UserFreshyZo
//
//  Created by Varsha Sahu on 26/03/26.
//

//
//  LabReportView.swift
//  UserFreshyZo
//

import SwiftUI

// MARK: - Data Models

struct MilkReport: Identifiable {
    let id = UUID()
    let milkName: String        // e.g. "FreshyZo Cow Milk"
    let testedDate: String      // e.g. "2025-10-27"
    let tests: [ReportTest]
}

struct ReportTest: Identifiable {
    let id = UUID()
    let no: String
    let name: String
    let validRange: String
    let result: String          // "Pass", "Fail", or a value like "3.6%"

    var isPass: Bool { result.lowercased() == "pass" }
    var isNumeric: Bool { result.contains("%") }
}

// MARK: - Mock Data

extension MilkReport {
    static let mockReports: [MilkReport] = [
        MilkReport(
            milkName: "FreshyZo Cow Milk",
            testedDate: "2025-10-27",
            tests: [
                ReportTest(no: "1.", name: "Fat",         validRange: "6.0 – 7.0", result: "3.6%"),
                ReportTest(no: "2.", name: "SNF",         validRange: "8.5 – 9.5", result: "8.9%"),
                ReportTest(no: "3.", name: "Urea",        validRange: "–",         result: "Pass"),
                ReportTest(no: "4.", name: "Starch",      validRange: "–",         result: "Pass"),
                ReportTest(no: "5.", name: "Acidity",     validRange: "–",         result: "Pass"),
                ReportTest(no: "6.", name: "Detergent",   validRange: "–",         result: "Pass"),
                ReportTest(no: "7.", name: "Antibiotics", validRange: "–",         result: "Pass"),
                ReportTest(no: "8.", name: "Caustic Soda",validRange: "–",         result: "Pass"),
            ]
        ),
        MilkReport(
            milkName: "FreshyZo Buffalo Milk",
            testedDate: "2025-10-27",
            tests: [
                ReportTest(no: "1.", name: "Fat",         validRange: "6.0 – 7.0", result: "6.5%"),
                ReportTest(no: "2.", name: "SNF",         validRange: "8.5 – 9.5", result: "8.9%"),
                ReportTest(no: "3.", name: "Urea",        validRange: "–",         result: "Pass"),
                ReportTest(no: "4.", name: "Starch",      validRange: "–",         result: "Pass"),
                ReportTest(no: "5.", name: "Acidity",     validRange: "–",         result: "Pass"),
                ReportTest(no: "6.", name: "Detergent",   validRange: "–",         result: "Pass"),
                ReportTest(no: "7.", name: "Antibiotics", validRange: "–",         result: "Pass"),
                ReportTest(no: "8.", name: "Caustic Soda",validRange: "–",         result: "Pass"),
            ]
        )
    ]
}

// MARK: - Main Lab Report View

struct LabReportView: View {

    let reports: [MilkReport]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(reports) { report in
                    // ── Subview: Single Report Card ───────────────────────
                    ReportCardView(report: report)
                }

                // ── Subview: Interpretation Section ──────────────────────
                InterpretationView()
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("FRESHYZO · LAB REPORTS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "#2E7D32"))
                        .kerning(1.2)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

// MARK: - Subview: Single Report Card

struct ReportCardView: View {
    let report: MilkReport

    var body: some View {
        VStack(spacing: 0) {

            // ── Header ────────────────────────────────────────────────────
            VStack(spacing: 4) {
                Text(report.milkName)
                    .font(.title3).bold()
                    .foregroundColor(.white)
                Text("QUALITY TEST REPORT")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.85))
                    .kerning(1.5)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                LinearGradient(
                    colors: [Color(hex: "#2E7D32"), Color(hex: "#43A047")],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16, corners: [.topLeft, .topRight])

            // ── Table Header ──────────────────────────────────────────────
            HStack {
                Text("SR.")
                    .frame(width: 30, alignment: .leading)
                Text("TEST NAME")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("VALID RANGE")
                    .frame(width: 90, alignment: .center)
                Text("RESULT")
                    .frame(width: 70, alignment: .center)
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(Color(hex: "#2E7D32"))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.white)

            Divider()

            // ── Test Rows ─────────────────────────────────────────────────
            VStack(spacing: 0) {
                ForEach(report.tests) { test in
                    ReportRowView(test: test)
                    if test.id != report.tests.last?.id {
                        Divider().padding(.horizontal, 16)
                    }
                }
            }
            .background(Color.white)

            // ── Footer ────────────────────────────────────────────────────
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Circle().fill(Color.orange).frame(width: 8, height: 8)
                    Text("Tested — \(report.testedDate)")
                        .font(.caption).fontWeight(.semibold)
                }
                HStack(spacing: 6) {
                    Circle().fill(Color(hex: "#2E7D32")).frame(width: 8, height: 8)
                    Text("Pass: Pure Milk — No adulteration detected.")
                        .font(.caption)
                }
                HStack(spacing: 6) {
                    Circle().fill(Color.red).frame(width: 8, height: 8)
                    Text("Fail: Adulterated Milk — Contains harmful additives.")
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
        }
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 3)
    }
}

// MARK: - Subview: Single Test Row

struct ReportRowView: View {
    let test: ReportTest

    var body: some View {
        HStack {
            Text(test.no)
                .frame(width: 30, alignment: .leading)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(test.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)

            Text(test.validRange)
                .frame(width: 90, alignment: .center)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Result badge
            Text(test.result)
                .font(.caption).fontWeight(.semibold)
                .foregroundColor(Color(hex: "#2E7D32"))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(hex: "#2E7D32").opacity(0.12))
                .cornerRadius(20)
                .frame(width: 70, alignment: .center)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white)
    }
}

// MARK: - Subview: Interpretation Section

struct InterpretationSectionItem: Identifiable {
    let id = UUID()
    let title: String
    let lines: [String]
}

struct InterpretationView: View {

    private let items: [InterpretationSectionItem] = [
        InterpretationSectionItem(title: "1. FAT (Milk Fat Content)", lines: [
            "Butterfat portion in milk.",
            "Cow Milk: 3.5% – 3.9%",
            "Buffalo Milk: 8.5 – 8.8%"
        ]),
        InterpretationSectionItem(title: "2. SNF (Solids Not Fat)", lines: [
            "Includes casein, lactose, vitamins, minerals.",
            "Cow Milk SNF: 7.5% – 8.5%",
            "Buffalo Milk SNF: 8.5% – 9.5%"
        ]),
        InterpretationSectionItem(title: "3. Urea", lines: [
            "✅ Pass  No urea detected",
            "❌ Fail   Urea adulteration detected"
        ]),
        InterpretationSectionItem(title: "4. Starch", lines: [
            "✅ Pass  No starch detected",
            "❌ Fail   Starch adulteration detected"
        ]),
        InterpretationSectionItem(title: "5. Acidity", lines: [
            "✅ Pass  Acidity within acceptable limits (fresh milk)",
            "❌ Fail   Acidity exceeds acceptable limits (spoiled or poor-quality milk)"
        ]),
        InterpretationSectionItem(title: "6. Detergent", lines: [
            "✅ Pass  No detergent detected",
            "❌ Fail   Detergent adulteration detected"
        ]),
        InterpretationSectionItem(title: "7. Antibiotics", lines: [
            "✅ Pass  No antibiotics detected",
            "❌ Fail   Antibiotics found"
        ]),
        InterpretationSectionItem(title: "8. Caustic Soda", lines: [
            "✅ Pass  No caustic soda detected",
            "❌ Fail   Caustic soda found"
        ]),
    ]

    var body: some View {
        VStack(spacing: 0) {

            // Header
            VStack(alignment: .leading, spacing: 2) {
                Text("Interpretation")
                    .font(.title3).bold()
                    .foregroundColor(.white)
                Text("UNDERSTANDING YOUR TEST RESULTS")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .kerning(1.2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                LinearGradient(
                    colors: [Color(hex: "#2E7D32"), Color(hex: "#43A047")],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16, corners: [.topLeft, .topRight])

            // Items
            VStack(spacing: 0) {
                ForEach(items) { item in
                    InterpretationItemView(item: item)
                    if item.id != items.last?.id {
                        Divider().padding(.horizontal, 16)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
        }
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 3)
    }
}

// MARK: - Subview: Single Interpretation Item

struct InterpretationItemView: View {
    let item: InterpretationSectionItem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.title)
                .font(.subheadline).bold()
            ForEach(item.lines, id: \.self) { line in
                Text(line)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        // Green left border
        .overlay(
            Rectangle()
                .fill(Color(hex: "#2E7D32"))
                .frame(width: 3),
            alignment: .leading
        )
    }
}

// MARK: - Corner Radius Helper

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LabReportView(reports: MilkReport.mockReports)
    }
}
