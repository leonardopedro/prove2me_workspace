-- Generated from ChapterUnboundedSpectralModel.lean — theorem BookProof.UnboundedSpectralModel.op_resOp
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterStoneResolvent
open BookProof.UnboundedSpectralModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum


theorem BookProof.UnboundedSpectralModel.op_resOp (T : UnboundedSelfAdjoint H) (y : H) :
    T.op ⟨resOp T y, resOp_mem T y⟩ = y + Complex.I • resOp T y := by sorry
