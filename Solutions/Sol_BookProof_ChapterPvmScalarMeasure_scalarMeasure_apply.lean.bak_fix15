-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.scalarMeasure_apply
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
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
    scalarMeasure P S n E = ∑' ψ : S, (2 : ENNReal)⁻¹ ^ n ψ * pvmMeasure P (ψ : H) E := by

  rw [scalarMeasure, Measure.sum_apply _ hE]
  simp
