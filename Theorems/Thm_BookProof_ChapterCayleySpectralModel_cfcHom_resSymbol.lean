-- Generated from ChapterCayleySpectralModel.lean — theorem BookProof.ChapterCayleySpectralModel.cfcHom_resSymbol
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


theorem BookProof.ChapterCayleySpectralModel.cfcHom_resSymbol (y : H) :
    cfcHom (isStarNormal_cayleyCLM T) (resSymbol T) y = ((T.res (-1) y : T.domain) : H) := by sorry
