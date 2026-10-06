-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.unitCell_isCompleteGaugeFixing'
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
import Theorems.Thm_BookProof_ChapterGaugeComprehensiveFixing_shift_smul_def
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]
variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution :
    IsCompleteGaugeFixing' (Multiplicative ℤ) unitCell := by

  rintro s ⟨hs0, hs1⟩ t ⟨ht0, ht1⟩ g hg
  rw [shift_smul_def] at hg
  have hlt : (Multiplicative.toAdd g : ℤ) < 1 := by
    have : ((Multiplicative.toAdd g : ℤ) : ℝ) < ((1 : ℤ) : ℝ) := by push_cast; linarith
    exact_mod_cast this
  have hgt : (-1 : ℤ) < (Multiplicative.toAdd g : ℤ) := by
    have : (((-1 : ℤ)) : ℝ) < ((Multiplicative.toAdd g : ℤ) : ℝ) := by push_cast; linarith
    exact_mod_cast this
  have hz : (Multiplicative.toAdd g : ℤ) = 0 := by omega
  rw [hz] at hg
  simpa using hg
