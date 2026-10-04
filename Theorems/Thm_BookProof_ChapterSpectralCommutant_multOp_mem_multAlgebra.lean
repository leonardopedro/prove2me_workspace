-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.multOp_mem_multAlgebra
import Definitions.Def_ChapterLinftyMaximalAbelian
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterA4
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.multOp_mem_multAlgebra (ψ : α → ℂ) (hψ : MemLp ψ ⊤ μ) :
    multOp ψ hψ ∈ multAlgebra μ := by sorry
