-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.multOp_mem_multAlgebra
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (ψ : α → ℂ) (hψ : MemLp ψ ⊤ μ) :
    multOp ψ hψ ∈ multAlgebra μ := ⟨ψ, hψ, rfl⟩
