-- Generated from ChapterUnboundedSpectralModel.lean — theorem BookProof.UnboundedSpectralModel.cayley_pointwise
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
open BookProof.UnboundedSpectralModel


noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.UnboundedSpectralModel.cayley_pointwise (w : ℂ) :
    w - (starRingEnd ℂ) w - (2 * Complex.I) * ((starRingEnd ℂ) w * w)
      = (2 * Complex.I) * (((w.im - ‖w‖ ^ 2 : ℝ) : ℂ)) := by sorry
