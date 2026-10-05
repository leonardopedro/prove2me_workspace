-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.centralizer_cfcSet
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_contCommutant_mem_multAlgebra
import Theorems.Thm_BookProof_ChapterSpectralCommutant_conjSpectral_conjSpectralSymm
import Theorems.Thm_BookProof_ChapterSpectralCommutant_mem_multModel_iff
import Theorems.Thm_BookProof_ChapterSpectralCommutant_commutesWithContMult_conjSpectralSymm
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
theorem solution : (cfcSet T hT).centralizer = multModel T hT xi hcyc := by

  apply Set.eq_of_subset_of_subset
  · intro S hS
    have hcomm : ∀ g : C(spectrum ℂ T, ℂ), cfcHom hT g * S = S * cfcHom hT g := fun g =>
      hS _ ⟨g, rfl⟩
    rw [mem_multModel_iff]
    exact contCommutant_mem_multAlgebra (commutesWithContMult_conjSpectralSymm T hT xi hcyc hcomm)
  · rintro S hS R ⟨g, rfl⟩
    obtain ⟨ψ, hψ, hSeq⟩ := (mem_multModel_iff T hT xi hcyc S).1 hS
    have hS' : S = conjSpectral T hT xi hcyc (multOp ψ hψ) := by
      rw [← hSeq, conjSpectral_conjSpectralSymm]
    subst hS'
    refine ContinuousLinearMap.ext fun v => ?_
    simp only [ContinuousLinearMap.mul_apply, conjSpectral_apply]
    have hcomm := multOp_comm (μ := spectralMeasure T hT xi) ψ (fun z => g z) hψ
      (contMemLpTop _ g)
    have hkey := congrArg
      (fun P : Lp ℂ 2 (spectralMeasure T hT xi) →L[ℂ] Lp ℂ 2 (spectralMeasure T hT xi) =>
        P ((spectralUnitary T hT xi hcyc).symm v)) hcomm
    simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hkey
    have h1 : spectralUnitary T hT xi hcyc
          (mulRep (spectralMeasure T hT xi) g
            (multOp ψ hψ ((spectralUnitary T hT xi hcyc).symm v)))
        = cfcHom hT g (spectralUnitary T hT xi hcyc
            (multOp ψ hψ ((spectralUnitary T hT xi hcyc).symm v))) :=
      spectralUnitary_intertwines_cfc T hT xi hcyc g _
    have h2 : (spectralUnitary T hT xi hcyc).symm (cfcHom hT g v)
        = mulRep (spectralMeasure T hT xi) g ((spectralUnitary T hT xi hcyc).symm v) := by
      have := spectralUnitary_intertwines_cfc T hT xi hcyc g
        ((spectralUnitary T hT xi hcyc).symm v)
      rw [LinearIsometryEquiv.apply_symm_apply] at this
      rw [← this, LinearIsometryEquiv.symm_apply_apply]
    rw [h2, ← h1]
    exact congrArg (spectralUnitary T hT xi hcyc) hkey.symm
