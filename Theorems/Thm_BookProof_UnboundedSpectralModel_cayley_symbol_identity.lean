-- Generated from ChapterUnboundedSpectralModel.lean — theorem BookProof.UnboundedSpectralModel.cayley_symbol_identity
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterStoneResolvent
open BookProof.UnboundedSpectralModel


noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.UnboundedSpectralModel.cayley_symbol_identity (T : UnboundedSelfAdjoint H) :
    coordFn (resOp T) - star (coordFn (resOp T))
        - (2 * Complex.I) • (star (coordFn (resOp T)) * coordFn (resOp T))
      = (2 * Complex.I) • cayleyFn T := by sorry
