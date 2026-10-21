-- Generated from ChapterAbelianCyclicCommutant.lean — solution of BookProof.ChapterAbelianCyclicCommutant.commutesWithContMult_conjRepSymm
import Mathlib
import Definitions.Def_ChapterAbelianCyclicCommutant
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_cyclicRepUnitary_intertwines
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
theorem solution {S : H →L[ℂ] H}
    (hS : ∀ g : C(X, ℂ), pi g * S = S * pi g) :
    CommutesWithContMult (conjRepSymm pi xi hcyc S) := by

  intro g
  refine ContinuousLinearMap.ext fun u => ?_
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, conjRepSymm_apply]
  have h1 : cyclicRepUnitary pi xi hcyc (mulRep (repMeasure pi xi) g u)
      = pi g (cyclicRepUnitary pi xi hcyc u) :=
    cyclicRepUnitary_intertwines pi xi hcyc g u
  have h2 := congrArg (fun P : H →L[ℂ] H => P (cyclicRepUnitary pi xi hcyc u)) (hS g)
  simp only [ContinuousLinearMap.mul_apply] at h2
  have h3 : cyclicRepUnitary pi xi hcyc
        (mulRep (repMeasure pi xi) g
          ((cyclicRepUnitary pi xi hcyc).symm (S (cyclicRepUnitary pi xi hcyc u))))
      = pi g (S (cyclicRepUnitary pi xi hcyc u)) := by
    rw [cyclicRepUnitary_intertwines pi xi hcyc g, LinearIsometryEquiv.apply_symm_apply]
  rw [h1, ← h2, ← h3, LinearIsometryEquiv.symm_apply_apply]
