-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.commutesWithContMult_conjSpectralSymm
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_spectralUnitary_intertwines_cfc
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
  (hcyc : DenseRange (cfcVec T hT xi))

set_option maxHeartbeats 1000000 in
theorem solution {S : H →L[ℂ] H}
    (hS : ∀ g : C(spectrum ℂ T, ℂ), cfcHom hT g * S = S * cfcHom hT g) :
    CommutesWithContMult (conjSpectralSymm T hT xi hcyc S) := by

  intro g
  refine ContinuousLinearMap.ext fun u => ?_
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, conjSpectralSymm_apply]
  have h1 : spectralUnitary T hT xi hcyc (mulRep (spectralMeasure T hT xi) g u)
      = cfcHom hT g (spectralUnitary T hT xi hcyc u) :=
    spectralUnitary_intertwines_cfc T hT xi hcyc g u
  have h2 := congrArg (fun P : H →L[ℂ] H => P (spectralUnitary T hT xi hcyc u)) (hS g)
  simp only [ContinuousLinearMap.mul_apply] at h2
  have h3 : spectralUnitary T hT xi hcyc
        (mulRep (spectralMeasure T hT xi) g
          ((spectralUnitary T hT xi hcyc).symm (S (spectralUnitary T hT xi hcyc u))))
      = cfcHom hT g (S (spectralUnitary T hT xi hcyc u)) := by
    rw [spectralUnitary_intertwines_cfc T hT xi hcyc g, LinearIsometryEquiv.apply_symm_apply]
  rw [h1, ← h2, ← h3, LinearIsometryEquiv.symm_apply_apply]
