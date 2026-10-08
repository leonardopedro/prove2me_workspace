-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.contCommutant_mem_multAlgebra
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterSpectralCommutant


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]

theorem BookProof.ChapterSpectralCommutant.contCommutant_mem_multAlgebra {S : Lp ℂ 2 mu →L[ℂ] Lp ℂ 2 mu}
    (hS : CommutesWithContMult S) : S ∈ multAlgebra mu := by sorry
