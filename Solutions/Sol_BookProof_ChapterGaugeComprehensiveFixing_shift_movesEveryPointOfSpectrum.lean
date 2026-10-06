-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.shift_movesEveryPointOfSpectrum
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
    MovesEveryPointOfSpectrum (Multiplicative ℤ) ℝ := by

  intro g hg x hx
  rw [shift_smul_def] at hx
  apply hg
  have h0 : ((Multiplicative.toAdd g : ℤ) : ℝ) = 0 := by linarith
  have : (Multiplicative.toAdd g : ℤ) = 0 := by exact_mod_cast h0
  exact Multiplicative.toAdd.injective this
