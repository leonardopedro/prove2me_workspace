-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.multOp_mem_multAlgebra
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (ψ : α → ℂ) (hψ : MemLp ψ ⊤ μ) :
    multOp ψ hψ ∈ multAlgebra μ := ⟨ψ, hψ, rfl⟩
