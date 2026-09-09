-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.norm_sub_proj_le_of_mem_range
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
open BookProof.ChapterSirkGramCutoff










noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (V : F →L[ℂ] E)
    (hV : (adjoint V).comp V = ContinuousLinearMap.id ℂ F)
    (x : E) {y : E} (hy : ∃ z, V z = y) :
    ‖x - V (adjoint V x)‖ ≤ ‖x - y‖ := by

  obtain ⟨z, rfl⟩ := hy
  set Q := V (adjoint V x) with hQ
  have hVadj : ∀ t : F, adjoint V (V t) = t := by
    intro t
    have h := congrArg (fun (A : F →L[ℂ] F) => A t) hV
    simpa using h
  have hperp : ∀ t : F, ⟪x - Q, V t⟫_ℂ = 0 := by
    intro t
    have h1 : ⟪V t, x - Q⟫_ℂ = ⟪t, adjoint V (x - Q)⟫_ℂ :=
      (ContinuousLinearMap.adjoint_inner_right V t (x - Q)).symm
    have h2 : adjoint V (x - Q) = 0 := by
      rw [map_sub, hQ, hVadj]; simp
    rw [← inner_conj_symm, h1, h2, inner_zero_right, map_zero]
  have hkey : ⟪x - Q, x - V z⟫_ℂ = ⟪x - Q, x - Q⟫_ℂ := by
    have hsp : x - V z = (x - Q) + V (adjoint V x - z) := by
      rw [map_sub, hQ]; abel
    rw [hsp, inner_add_right, hperp, add_zero]
  have h2 : ‖x - Q‖ ^ 2 = RCLike.re ⟪x - Q, x - V z⟫_ℂ := by
    rw [hkey, inner_self_eq_norm_sq]
  have h3 : RCLike.re ⟪x - Q, x - V z⟫_ℂ ≤ ‖x - Q‖ * ‖x - V z‖ :=
    le_trans (RCLike.re_le_norm _) (norm_inner_le_norm _ _)
  rcases eq_or_lt_of_le (norm_nonneg (x - Q)) with h0 | h0
  · rw [← h0]; positivity
  · have h4 := h2.trans_le h3
    nlinarith
