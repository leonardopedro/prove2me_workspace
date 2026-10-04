-- Generated from ChapterUnboundedSpectralModel.lean — theorem BookProof.UnboundedSpectralModel.cayley_pointwise
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterA4
open BookProof.UnboundedSpectralModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum


theorem BookProof.UnboundedSpectralModel.cayley_pointwise (w : ℂ) :
    w - (starRingEnd ℂ) w - (2 * Complex.I) * ((starRingEnd ℂ) w * w)
      = (2 * Complex.I) * (((w.im - ‖w‖ ^ 2 : ℝ) : ℂ)) := by sorry
