-- Generated from ChapterCayleySpectralModel.lean — solution of BookProof.ChapterCayleySpectralModel.cfcHom_opSymbol
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_res_neg_one_eq_cayley
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_isStarNormal_cayleyCLM
import Theorems.Thm_BookProof_ChapterCayleySpectralModel_cfcHom_opSymbol_eq
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
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
theorem solution (y : H) :
    cfcHom (isStarNormal_cayleyCLM T) (opSymbol T) y = T.op (T.res (-1) y) := by

  have hop : T.op (T.res (-1) y)
      = y + (((-1 : ℝ) : ℂ) * Complex.I) • ((T.res (-1) y : T.domain) : H) :=
    T.op_res (by norm_num) y
  rw [cfcHom_opSymbol_eq, hop, res_neg_one_eq_cayley]
  have hI : (((-1 : ℝ) : ℂ) * Complex.I) * (2 * Complex.I)⁻¹ = -(2 : ℂ)⁻¹ := by
    push_cast
    field_simp
  simp only [ContinuousLinearMap.smul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.one_apply, cayleyCLM_apply, smul_smul, hI]
  module
