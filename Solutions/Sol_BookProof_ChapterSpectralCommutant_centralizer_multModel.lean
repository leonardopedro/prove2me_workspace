-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.centralizer_multModel
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_multAlgebra_comm
import Theorems.Thm_BookProof_ChapterSpectralCommutant_centralizer_multAlgebra
import Theorems.Thm_BookProof_ChapterSpectralCommutant_conjSpectral_mul
import Theorems.Thm_BookProof_ChapterSpectralCommutant_mem_multModel_iff
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
theorem solution :
    (multModel T hT xi hcyc).centralizer = multModel T hT xi hcyc := by

  apply Set.eq_of_subset_of_subset
  · intro S hS
    rw [mem_multModel_iff]
    rw [← centralizer_multAlgebra (μ := spectralMeasure T hT xi)]
    intro A hA
    have hmem : conjSpectral T hT xi hcyc A ∈ multModel T hT xi hcyc := ⟨A, hA, rfl⟩
    have h := hS _ hmem
    refine ContinuousLinearMap.ext fun u => ?_
    have h2 := congrArg (fun P : H →L[ℂ] H => P (spectralUnitary T hT xi hcyc u)) h
    simp only [ContinuousLinearMap.mul_apply, conjSpectral_apply,
      LinearIsometryEquiv.symm_apply_apply] at h2
    simp only [ContinuousLinearMap.mul_apply, conjSpectralSymm_apply]
    have h3 := congrArg (spectralUnitary T hT xi hcyc).symm h2
    rwa [LinearIsometryEquiv.symm_apply_apply] at h3
  · rintro S hS R ⟨A, hA, rfl⟩
    obtain ⟨B, hB, rfl⟩ := hS
    rw [← conjSpectral_mul, ← conjSpectral_mul, multAlgebra_comm hA hB]
