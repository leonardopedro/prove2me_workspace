-- Generated from ChapterCayleySpectralModel.lean — theorem BookProof.ChapterCayleySpectralModel.res_one_eq_cayley
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterCayleyTransform
open BookProof.ChapterCayleySpectralModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open MeasureTheory


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform BookProof.ChapterAbelianGelfandModel
open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCayleySpectralModel.res_one_eq_cayley (y : H) :
    ((T.res 1 y : T.domain) : H) = (2 * Complex.I)⁻¹ • ((cayley T).symm y - y) := by sorry
