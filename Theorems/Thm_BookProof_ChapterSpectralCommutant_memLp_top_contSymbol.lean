-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.memLp_top_contSymbol
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.memLp_top_contSymbol {S : Lp ℂ 2 mu →L[ℂ] Lp ℂ 2 mu} (hS : CommutesWithContMult S) :
    MemLp (symbol S) ⊤ mu := by sorry
