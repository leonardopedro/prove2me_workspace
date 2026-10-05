-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.restrictCyclic_apply
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_restrictSub_apply
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (P : Pvm X H) (ψ : H)
    {E : Set X} (hE : MeasurableSet E) (v : cyclicSubspace P ψ) :
    (((restrictCyclic P ψ).p E v : cyclicSubspace P ψ) : H) = P.p E (v : H) := by

  haveI : CompleteSpace (cyclicSubspace P ψ) :=
    (Submodule.isClosed_topologicalClosure _).completeSpace_coe
  exact restrictSub_apply P _ (fun _ hE _ hv => cyclicSubspace_invariant P ψ hE hv) hE v
