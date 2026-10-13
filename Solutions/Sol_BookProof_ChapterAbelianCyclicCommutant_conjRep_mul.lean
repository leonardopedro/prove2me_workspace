-- Generated from ChapterAbelianCyclicCommutant.lean — solution of BookProof.ChapterAbelianCyclicCommutant.conjRep_mul
import Mathlib
import Definitions.Def_ChapterAbelianCyclicCommutant
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterAbelianCyclicModel
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
theorem solution (A B : Lp ℂ 2 (repMeasure pi xi) →L[ℂ] Lp ℂ 2 (repMeasure pi xi)) :
    conjRep pi xi hcyc (A * B) = conjRep pi xi hcyc A * conjRep pi xi hcyc B := by

  refine ContinuousLinearMap.ext fun v => ?_
  simp [ContinuousLinearMap.mul_apply]
