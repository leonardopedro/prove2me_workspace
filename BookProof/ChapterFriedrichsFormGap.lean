import Mathlib
import BookProof.ChapterFriedrichsExtension

/-!
# Chapter FriedrichsFormGap — the Friedrichs extension inherits the gap of its core

`CONSOLIDATED_PLAN.md` (top work package) needs the **infinite** selected operator, not just
the finite truncations, to carry the certified positive lower bound.  The operator the
Hashimoto/shift-invert algorithm selects is the Friedrichs extension constructed in
`BookProof.FriedrichsExtension` (`friedrichs_extension_exists`,
`friedrichs_hashimoto_selects`).  This chapter proves the missing transfer:

> if the symmetric positive core satisfies `⟪x, H x⟫ ≥ μ‖x‖²` on its (dense) domain, then
> the Friedrichs extension satisfies `⟪y, A y⟫ ≥ μ‖y‖²` on **its** domain.

No boundedness and no spectral theorem for unbounded operators are used: the argument is
carried out in the form completion, where the core bound `‖x‖₁² ≥ (1+μ)‖x‖²` extends by
continuity to the whole form space (`formSpace_norm_bound`), and the extension's quadratic
form at `y = formExt k` is exactly `‖k‖₁² − ‖y‖²`.

## Deliverables

* `formSpace_norm_bound` — the core form bound extends to the form completion;
* `friedrichs_quadForm_lower_bound` — the constructed extension `A = S⁻¹ − 1` satisfies
  `⟪y, A y⟫ ≥ μ‖y‖²`;
* `friedrichs_extension_form_gap` — the packaged statement: the Friedrichs extension exists,
  is a positive self-adjoint extension of `H`, is the operator whose Hashimoto shift-invert
  at `γ = 1` is the resolvent `S` (hence the one the algorithm selects), and inherits the
  lower bound `μ`.
-/

noncomputable section

namespace BookProof.FriedrichsFormGap

open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The core form bound extends to the form completion.**  If `⟪x, H x⟫ ≥ μ‖x‖²` on the
domain, then `(1 + μ)‖formExt k‖² ≤ ‖k‖²` for every element `k` of the completed form
space — by continuity, since the inequality holds on the dense image of the domain. -/
theorem formSpace_norm_bound (P : PosSymOp F) {mu : ℝ}
    (hmu : ∀ x : P.dom, mu * ‖(x : F)‖ ^ 2 ≤ quadForm P.op x) (k : FormSpace P) :
    (1 + mu) * ‖formExt P k‖ ^ 2 ≤ ‖k‖ ^ 2 := by
  refine UniformSpace.Completion.induction_on k ?_ ?_
  · exact isClosed_le (by fun_prop) (by fun_prop)
  · intro x
    have hnorm : ‖((x : FormSpace P))‖ = ‖x‖ := UniformSpace.Completion.norm_coe x
    have hsq := norm_sq_eq x
    have hq : (inner ℂ (toAmbient x) (P.op (toDom x)) : ℂ).re = quadForm P.op (toDom x) := by
      rw [quadForm, toAmbient_eq]
    have hb := hmu (toDom x)
    have hxa : ((toDom x : P.dom) : F) = toAmbient x := (toAmbient_eq x).symm
    rw [hxa] at hb
    rw [formExt_coe, hnorm, hsq, hq]
    linarith

/-- **The Friedrichs extension inherits the lower bound of its core.**  With
`S = (H + 1)⁻¹ = friedrichsResolvent P` and `A = S⁻¹ − 1` the constructed extension, a core
bound `⟪x, H x⟫ ≥ μ‖x‖²` gives `⟪y, A y⟫ ≥ μ‖y‖²` for every `y` in the domain of `A`. -/
theorem friedrichs_quadForm_lower_bound (P : PosSymOp F)
    (hinj : Function.Injective (friedrichsResolvent P)) {mu : ℝ}
    (hmu : ∀ x : P.dom, mu * ‖(x : F)‖ ^ 2 ≤ quadForm P.op x)
    (y : LinearMap.range ((friedrichsResolvent P) : F →ₗ[ℂ] F)) :
    mu * ‖(y : F)‖ ^ 2 ≤ quadForm (invShiftOperator (friedrichsResolvent P) hinj 1) y := by
  have hy : friedrichsResolvent P (preim (friedrichsResolvent P) y) = (y : F) :=
    preim_spec _ y
  -- the quadratic form of `A = S⁻¹ − 1` at `y = S u`
  have hq : quadForm (invShiftOperator (friedrichsResolvent P) hinj 1) y
      = (inner ℂ (y : F) (preim (friedrichsResolvent P) y) : ℂ).re - 1 * ‖(y : F)‖ ^ 2 := by
    rw [quadForm, invShiftOperator_apply, inner_sub_right, inner_smul_right, Complex.sub_re,
      inner_self_eq_norm_sq_to_K]
    congr 1
    simp [← Complex.ofReal_pow]
  -- `⟪y, u⟫ = ⟪S u, u⟫ = ‖formRiesz u‖²`
  have hyu : (inner ℂ (y : F) (preim (friedrichsResolvent P) y) : ℂ).re
      = ‖formRiesz P (preim (friedrichsResolvent P) y)‖ ^ 2 := by
    have h1 : (inner ℂ (y : F) (preim (friedrichsResolvent P) y) : ℂ)
        = starRingEnd ℂ (inner ℂ (preim (friedrichsResolvent P) y)
            (friedrichsResolvent P (preim (friedrichsResolvent P) y)) : ℂ) := by
      rw [← inner_conj_symm, hy]
    rw [h1, inner_friedrichsResolvent, Complex.conj_re]
    exact re_inner_self (F := FormSpace P) _
  -- and `formExt (formRiesz u) = S u = y`
  have hext : formExt P (formRiesz P (preim (friedrichsResolvent P) y)) = (y : F) := by
    rw [← hy, friedrichsResolvent_apply]
  have hbound := formSpace_norm_bound P hmu (formRiesz P (preim (friedrichsResolvent P) y))
  rw [hext] at hbound
  rw [hq, hyu]
  nlinarith [hbound]

/-- **The packaged statement.**  A densely defined positive symmetric operator whose form is
bounded below by `μ` on its domain has a Friedrichs extension `A` which

* is a positive self-adjoint extension of `H`,
* has the bounded resolvent `S = (H + 1)⁻¹` as its Hashimoto shift-invert at `γ = 1` — so it
  is the operator the algorithm selects (`FriedrichsExtension.friedrichs_hashimoto_selects`),
  and is determined by `S`, and
* inherits the lower bound: `⟪y, A y⟫ ≥ μ‖y‖²` on the whole domain of `A`.

This is the transfer of a certified positive lower bound from a core to the *infinite*
selected operator. -/
theorem friedrichs_extension_form_gap (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    {mu : ℝ} (hmu : ∀ x : P.dom, mu * ‖(x : F)‖ ^ 2 ≤ quadForm P.op x) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (S : F →L[ℂ] F),
      IsPositiveSelfAdjointExtension P.op A ∧ IsShiftInvert A 1 S ∧
        IsSelfAdjoint S ∧ (∀ y : Dom, mu * ‖(y : F)‖ ^ 2 ≤ quadForm A y) := by
  have hinj : Function.Injective (friedrichsResolvent P) :=
    friedrichsResolvent_injective P hdense
  refine ⟨_, invShiftOperator (friedrichsResolvent P) hinj 1, friedrichsResolvent P, ?_,
    isShiftInvert_invShiftOperator _ hinj 1, friedrichsResolvent_isSelfAdjoint P,
    friedrichs_quadForm_lower_bound P hinj hmu⟩
  refine invShiftOperator_isPositiveSelfAdjointExtension (friedrichsResolvent P) hinj 1
    (friedrichsResolvent_isSelfAdjoint P) (friedrichsResolvent_pos P) (dom_le_range P) P.op ?_
  intro x
  have hpre : preim (friedrichsResolvent P) ⟨(x : F), dom_le_range P x.2⟩
      = (x : F) + P.op x :=
    preim_eq _ hinj _ (friedrichsResolvent_shift P x)
  rw [invShiftOperator_apply, hpre]
  push_cast
  module

end BookProof.FriedrichsFormGap

end
