-- Generated from ChapterCayleySpectralModel.lean — theorem BookProof.ChapterCayleySpectralModel.res_neg_one_eq_cayley
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.ChapterCayleyTransform
open BookProof.ChapterCayleySpectralModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open MeasureTheory


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform BookProof.ChapterAbelianGelfandModel
open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCayleySpectralModel.res_neg_one_eq_cayley (y : H) :
    ((T.res (-1) y : T.domain) : H) = (2 * Complex.I)⁻¹ • (y - cayley T y) := by sorry
