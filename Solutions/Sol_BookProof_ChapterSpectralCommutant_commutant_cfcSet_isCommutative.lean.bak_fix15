-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.commutant_cfcSet_isCommutative
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_multAlgebra_comm
import Theorems.Thm_BookProof_ChapterSpectralCommutant_conjSpectral_mul
import Theorems.Thm_BookProof_ChapterSpectralCommutant_centralizer_cfcSet
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
theorem solution {S R : H →L[ℂ] H}
    (hS : S ∈ (cfcSet T hT).centralizer) (hR : R ∈ (cfcSet T hT).centralizer) :
    S * R = R * S := by

  rw [centralizer_cfcSet T hT xi hcyc] at hS hR
  obtain ⟨A, hA, rfl⟩ := hS
  obtain ⟨B, hB, rfl⟩ := hR
  rw [← conjSpectral_mul, ← conjSpectral_mul, multAlgebra_comm hA hB]
