-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.resOp_eq_res
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_resOp_mem
open BookProof.UnboundedSpectralModel



noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) (y : H) :
    (⟨resOp T y, resOp_mem T y⟩ : T.domain) = T.res 1 y := rfl
