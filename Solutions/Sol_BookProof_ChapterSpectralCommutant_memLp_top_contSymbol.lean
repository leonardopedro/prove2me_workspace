-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.memLp_top_contSymbol
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_contSymbol_ae_norm_le
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_stronglyMeasurable_symbol
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
theorem solution {S : Lp ℂ 2 mu →L[ℂ] Lp ℂ 2 mu} (hS : CommutesWithContMult S) :
    MemLp (symbol S) ⊤ mu :=
  memLp_top_of_bound (stronglyMeasurable_symbol S).aestronglyMeasurable ‖S‖
      (contSymbol_ae_norm_le hS)
