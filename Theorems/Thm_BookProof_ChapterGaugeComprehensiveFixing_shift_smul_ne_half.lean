-- Generated from ChapterGaugeComprehensiveFixing.lean — theorem BookProof.ChapterGaugeComprehensiveFixing.shift_smul_ne_half
import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
open BookProof.ChapterGaugeComprehensiveFixing



open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]
variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

theorem BookProof.ChapterGaugeComprehensiveFixing.shift_smul_ne_half {s : ℝ} (hs : s = 0 ∨ s = 1) (g : Multiplicative ℤ) :
    g • s ≠ (1 / 2 : ℝ) := by sorry
