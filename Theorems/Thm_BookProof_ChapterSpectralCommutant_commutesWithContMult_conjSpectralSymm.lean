-- Generated from ChapterSpectralCommutant.lean — theorem BookProof.ChapterSpectralCommutant.commutesWithContMult_conjSpectralSymm
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLinftyMaximalAbelian
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Definitions.Def_ChapterA4
open BookProof.ChapterSpectralCommutant

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
  (hcyc : DenseRange (cfcVec T hT xi))


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

theorem BookProof.ChapterSpectralCommutant.commutesWithContMult_conjSpectralSymm {S : H →L[ℂ] H}
    (hS : ∀ g : C(spectrum ℂ T, ℂ), cfcHom hT g * S = S * cfcHom hT g) :
    CommutesWithContMult (conjSpectralSymm T hT xi hcyc S) := by sorry
