-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.pvmMeasure_restrictCyclic
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_mem_cyclicSubspace_self
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_restrictCyclic_apply
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (P : Pvm X H) (ψ : H) :
    pvmMeasure (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩ = pvmMeasure P ψ := by

  refine Measure.ext_iff.mpr ?_
  intro E hE
  rw [pvmMeasure_apply _ _ hE, pvmMeasure_apply _ _ hE]
  have hnorm : ‖(restrictCyclic P ψ).p E ⟨ψ, mem_cyclicSubspace_self P ψ⟩‖ = ‖P.p E ψ‖ := by
    rw [← restrictCyclic_apply P ψ hE ⟨ψ, mem_cyclicSubspace_self P ψ⟩]
    rfl
  rw [hnorm]
