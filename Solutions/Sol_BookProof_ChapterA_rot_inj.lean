-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.rot_inj
import Mathlib
import Definitions.Def_ChapterA2e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) [Nontrivial H]
    {a b c d : ℂ} (h : rot θ a b = rot θ c d) : a = c ∧ b = d := by

  obtain ⟨x, hx⟩ := exists_ne (0 : H)
  have heq : a • x + b • θ x = c • x + d • θ x := by
    have := congr_arg (fun T : H →L[ℝ] H => T x) h; simpa [rot_apply] using this
  have hθx : θ x ≠ 0 := fun h0 => hx (θ.map_eq_zero_iff.mp h0)
  have hi := congr_arg (fun v => inner ℂ x v) heq
  simp only [inner_add_right, inner_smul_right, theta_inner_self_zero θ hθ x, mul_zero,
    add_zero] at hi
  have hxi : inner ℂ x x ≠ 0 := inner_self_ne_zero.2 hx
  have hac : a = c := mul_right_cancel₀ hxi hi
  refine ⟨hac, ?_⟩
  rw [hac] at heq
  have h5 : b • θ x = d • θ x := add_left_cancel heq
  have h6 := sub_eq_zero.2 h5
  rw [← sub_smul] at h6
  rcases smul_eq_zero.1 h6 with h1 | h1
  · exact sub_eq_zero.1 h1
  · exact absurd h1 hθx
