-- Generated from ChapterCayleySpectralModel.lean — solution of BookProof.ChapterCayleySpectralModel.spectralUnitary_opSymbol
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_isStarNormal_cayleyCLM
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_cfcHom_opSymbol
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_spectralUnitary_intertwines_cfc
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
variable (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution
    (hcyc : DenseRange (cfcVec (cayleyCLM T) (isStarNormal_cayleyCLM T) xi))
    (u : Lp ℂ 2 (spectralMeasure (cayleyCLM T) (isStarNormal_cayleyCLM T) xi)) :
    spectralUnitary (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hcyc
        (mulRep (spectralMeasure (cayleyCLM T) (isStarNormal_cayleyCLM T) xi) (opSymbol T) u)
      = T.op (T.res (-1) (spectralUnitary (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hcyc u)) := by

  rw [spectralUnitary_intertwines_cfc (cayleyCLM T) (isStarNormal_cayleyCLM T) xi hcyc
    (opSymbol T) u, cfcHom_opSymbol]
