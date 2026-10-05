-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.mem_multModel_iff
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_conjSpectral_conjSpectralSymm
import Theorems.Thm_BookProof_ChapterSpectralCommutant_conjSpectralSymm_conjSpectral
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
theorem solution (S : H →L[ℂ] H) :
    S ∈ multModel T hT xi hcyc ↔
      conjSpectralSymm T hT xi hcyc S ∈ multAlgebra (spectralMeasure T hT xi) := by

  constructor
  · rintro ⟨A, hA, rfl⟩
    rwa [conjSpectralSymm_conjSpectral]
  · intro h
    exact ⟨conjSpectralSymm T hT xi hcyc S, h, conjSpectral_conjSpectralSymm T hT xi hcyc S⟩
