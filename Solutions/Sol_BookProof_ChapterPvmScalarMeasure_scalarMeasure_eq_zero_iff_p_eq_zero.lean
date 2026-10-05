-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.scalarMeasure_eq_zero_iff_p_eq_zero
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Theorems.Thm_BookProof_ChapterPvmScalarMeasure_p_eq_zero_of_forall_measure_zero
import Theorems.Thm_BookProof_ChapterPvmScalarMeasure_scalarMeasure_eq_zero_iff
import Theorems.Thm_BookProof_ChapterPvmMeasure_pvmMeasure_eq_zero_iff
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
theorem solution {P : Pvm X H} {S : Set H} {n : S → ℕ}
    (hdense : Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H))
    {E : Set X} (hE : MeasurableSet E) :
    scalarMeasure P S n E = 0 ↔ P.p E = 0 := by

  rw [scalarMeasure_eq_zero_iff P S n hE]
  constructor
  · intro h
    exact p_eq_zero_of_forall_measure_zero hdense hE (fun ψ hψ => h ⟨ψ, hψ⟩)
  · intro h ψ
    rw [pvmMeasure_eq_zero_iff P (ψ : H) hE, h]
    rfl
