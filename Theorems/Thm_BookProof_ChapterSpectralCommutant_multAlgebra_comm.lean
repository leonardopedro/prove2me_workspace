-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.multAlgebra_comm
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.multAlgebra_comm {S R : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hS : S ∈ multAlgebra μ)
    (hR : R ∈ multAlgebra μ) : S * R = R * S := by sorry
