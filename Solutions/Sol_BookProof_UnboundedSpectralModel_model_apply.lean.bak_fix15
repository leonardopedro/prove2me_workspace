-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.model_apply
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_resOp_mem
import Theorems.Thm_BookProof_UnboundedSpectralModel_op_resOp
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_mem
open BookProof.UnboundedSpectralModel



noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) {mu : Measure (spectrum ℂ (resOp T))}
  (V : Lp ℂ 2 mu →ₗᵢ[ℂ] H)
  (hV : ∀ u : Lp ℂ 2 mu, V (mulRep mu (coordFn (resOp T)) u) = resOp T (V u))

set_option maxHeartbeats 1000000 in
theorem solution (u : Lp ℂ 2 mu) :
    T.op ⟨V (mulRep mu (coordFn (resOp T)) u), model_mem T V hV u⟩
      = V (u + Complex.I • mulRep mu (coordFn (resOp T)) u) := by

  have hsub : (⟨V (mulRep mu (coordFn (resOp T)) u), model_mem T V hV u⟩ : T.domain)
      = ⟨resOp T (V u), resOp_mem T (V u)⟩ := Subtype.ext (hV u)
  rw [hsub, op_resOp, map_add, map_smul, hV u]
