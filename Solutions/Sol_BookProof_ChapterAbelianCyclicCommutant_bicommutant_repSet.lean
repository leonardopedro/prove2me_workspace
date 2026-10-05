-- Generated from ChapterAbelianCyclicCommutant.lean — solution of BookProof.ChapterAbelianCyclicCommutant.bicommutant_repSet
import Mathlib
import Definitions.Def_ChapterAbelianCyclicCommutant
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_centralizer_repSet
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_centralizer_multModelRep
open BookProof.ChapterAbelianCyclicCommutant



noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralCommutant
open BookProof.ChapterAbelianCyclicModel


variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H) (hcyc : DenseRange (repVec pi xi))

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H) (hcyc : DenseRange (repVec pi xi))

set_option maxHeartbeats 1000000 in
theorem solution :
    (repSet pi).centralizer.centralizer = multModelRep pi xi hcyc := by

  rw [centralizer_repSet pi xi hcyc, centralizer_multModelRep pi xi hcyc]
