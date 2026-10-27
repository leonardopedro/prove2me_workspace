-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.model_symmetry_relation
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_mem
import Theorems.Thm_BookProof_UnboundedSpectralModel_model_apply
import Theorems.Thm_BookProof_FriedrichsSquare_IsFriedrichsSqExtension_symmetric
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
    (inner ℂ u (mulRep mu (coordFn (resOp T)) u) : ℂ)
        - inner ℂ (mulRep mu (coordFn (resOp T)) u) u
      = (2 * Complex.I)
          * inner ℂ (mulRep mu (coordFn (resOp T)) u) (mulRep mu (coordFn (resOp T)) u) := by

  set Z := mulRep mu (coordFn (resOp T)) with hZ
  have hx := T.symmetric ⟨V (Z u), model_mem T V hV u⟩ ⟨V (Z u), model_mem T V hV u⟩
  rw [model_apply T V hV u] at hx
  simp only at hx
  rw [V.inner_map_map, V.inner_map_map, inner_add_left, inner_add_right, inner_smul_left,
    inner_smul_right] at hx
  simp only [Complex.conj_I] at hx
  linear_combination hx
