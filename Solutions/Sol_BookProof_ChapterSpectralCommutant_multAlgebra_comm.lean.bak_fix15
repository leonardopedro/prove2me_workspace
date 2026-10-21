-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.multAlgebra_comm
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_comm
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution {S R : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hS : S ∈ multAlgebra μ)
    (hR : R ∈ multAlgebra μ) : S * R = R * S := by

  obtain ⟨ψ, hψ, rfl⟩ := hS
  obtain ⟨φ, hφ, rfl⟩ := hR
  have h := multOp_comm ψ φ hψ hφ
  simpa [ContinuousLinearMap.mul_def] using h
