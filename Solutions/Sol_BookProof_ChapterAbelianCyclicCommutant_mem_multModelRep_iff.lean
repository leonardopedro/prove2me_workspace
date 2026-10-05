-- Generated from ChapterAbelianCyclicCommutant.lean — solution of BookProof.ChapterAbelianCyclicCommutant.mem_multModelRep_iff
import Mathlib
import Definitions.Def_ChapterAbelianCyclicCommutant
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_conjRep_conjRepSymm
import Theorems.Thm_BookProof_ChapterAbelianCyclicCommutant_conjRepSymm_conjRep
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
theorem solution (S : H →L[ℂ] H) :
    S ∈ multModelRep pi xi hcyc ↔
      conjRepSymm pi xi hcyc S ∈ multAlgebra (repMeasure pi xi) := by

  constructor
  · rintro ⟨A, hA, rfl⟩
    rwa [conjRepSymm_conjRep]
  · intro h
    exact ⟨conjRepSymm pi xi hcyc S, h, conjRep_conjRepSymm pi xi hcyc S⟩
