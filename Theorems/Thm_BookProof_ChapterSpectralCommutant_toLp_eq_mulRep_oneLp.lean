-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.toLp_eq_mulRep_oneLp
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

omit [T2Space X] [mu.WeaklyRegular] in
theorem BookProof.ChapterSpectralCommutant.toLp_eq_mulRep_oneLp (g : C(X, ℂ)) :
    ContinuousMap.toLp 2 mu ℂ g = mulRep mu g (oneLp mu) := by sorry
