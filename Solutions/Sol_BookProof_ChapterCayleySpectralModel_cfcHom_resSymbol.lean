-- Generated from ChapterCayleySpectralModel.lean — solution of BookProof.ChapterCayleySpectralModel.cfcHom_resSymbol
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterCayleySpectralModel



open scoped InnerProductSpace
open MeasureTheory


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform BookProof.ChapterAbelianGelfandModel
open BookProof.ChapterSpectralMultiplication
open BookProof.ChapterCayleyTransform

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (y : H) :
    cfcHom (isStarNormal_cayleyCLM T) (resSymbol T) y = ((T.res (-1) y : T.domain) : H) := by

  rw [cfcHom_resSymbol_eq, res_neg_one_eq_cayley]
  simp
