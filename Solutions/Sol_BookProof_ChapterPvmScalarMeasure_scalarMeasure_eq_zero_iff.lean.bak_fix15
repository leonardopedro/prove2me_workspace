-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.scalarMeasure_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Theorems.Thm_BookProof_ChapterPvmScalarMeasure_scalarMeasure_apply
open BookProof.ChapterPvmScalarMeasure



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution (P : Pvm X H) (S : Set H) (n : S → ℕ) {E : Set X}
    (hE : MeasurableSet E) :
    scalarMeasure P S n E = 0 ↔ ∀ ψ : S, pvmMeasure P (ψ : H) E = 0 := by

  rw [scalarMeasure_apply P S n hE, ENNReal.tsum_eq_zero]
  refine forall_congr' fun ψ => ?_
  have hne : ((2 : ENNReal)⁻¹ ^ n ψ) ≠ 0 := by
    simp
  simp [mul_eq_zero, hne]
