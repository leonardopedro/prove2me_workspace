-- Generated from ChapterCayleySpectralModel.lean — solution of BookProof.ChapterCayleySpectralModel.cfcHom_resSymbol_eq
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_isStarNormal_cayleyCLM
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_cfcHom_coordFn
open BookProof.ChapterCayleySpectralModel



open scoped InnerProductSpace
open MeasureTheory


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform BookProof.ChapterAbelianGelfandModel
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution :
    cfcHom (isStarNormal_cayleyCLM T) (resSymbol T)
      = (2 * Complex.I)⁻¹ • (1 - cayleyCLM T) := by

  rw [resSymbol, map_smul, map_sub, map_one, cfcHom_coordFn]
