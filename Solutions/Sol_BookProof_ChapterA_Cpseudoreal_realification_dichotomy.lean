-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.Cpseudoreal_realification_dichotomy
import Mathlib
import Definitions.Def_ChapterA2e
import Theorems.Thm_BookProof_ChapterA_transK_sq
import Theorems.Thm_BookProof_ChapterA_transK_beta
import Theorems.Thm_BookProof_ChapterA_transK_realCommutes
import Theorems.Thm_BookProof_ChapterA_rot_inj
import Theorems.Thm_BookProof_ChapterA_qembed_eq_rot
import Theorems.Thm_BookProof_ChapterA_isRealSystemIso_trans_commuting
import Theorems.Thm_BookProof_ChapterA_rot_realCommutes
import Theorems.Thm_BookProof_ChapterA_transK_isometry
import Theorems.Thm_BookProof_ChapterA_Rpseudoreal_realCommutant_eq_quaternion
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial W]
    {M : System ℂ V} {N : System ℂ W} (hSchurN : IsSchurFull N)
    {θN : AntiUnitary W} (hθN : ∀ x, θN (θN x) = -x) (hθNc : CommutesAntiUnitary N θN)
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) :
    ∃ γ : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N γ ∧ (CLinear γ ∨ CAntilinear γ) := by

  -- `K = transK β` lies in the real commutant, so equals `qembed q = rot pK sK`.
  have hKcomm : RealCommutes N (transK β) := transK_realCommutes hβ
  obtain ⟨q, hq⟩ :=
    (Rpseudoreal_realCommutant_eq_quaternion N hSchurN hθN hθNc (transK β)).1 hKcomm
  set pK : ℂ := q.re + q.imI * Complex.I with hpKdef
  set sK : ℂ := q.imJ + q.imK * Complex.I with hsKdef
  have hKrot : transK β = rot θN pK sK := by rw [hq, qembed_eq_rot]
  -- `K` is an isometry ⇒ `‖pK‖² + ‖sK‖² = 1`.
  have hunitK : ‖pK‖ ^ 2 + ‖sK‖ ^ 2 = 1 := by
    obtain ⟨w, hw⟩ := exists_ne (0 : W)
    have h1 : ‖rot θN pK sK w‖ ^ 2 = ‖w‖ ^ 2 := by
      rw [← hKrot, transK_isometry]
    rw [rot_normSq θN hθN] at h1
    have hw2 : ‖w‖ ^ 2 ≠ 0 := by positivity
    have h2 : (‖pK‖ ^ 2 + ‖sK‖ ^ 2) * ‖w‖ ^ 2 = 1 * ‖w‖ ^ 2 := by rw [one_mul]; exact h1
    exact mul_right_cancel₀ hw2 h2
  -- `K² = -1` gives the two quaternion relations.
  have hKsq : rot θN pK sK ∘L rot θN pK sK = rot θN (-1) 0 := by
    have := transK_sq β
    rw [hKrot] at this
    rw [show rot θN pK sK ∘L rot θN pK sK = rot θN pK sK * rot θN pK sK from rfl, this]
    ext w; simp
  rw [rot_comp θN hθN] at hKsq
  obtain ⟨hC1, hC2⟩ := rot_inj θN hθN hKsq
  -- Case on whether `K = -mulI` (i.e. `β` already antilinear).
  by_cases hneg : pK = -Complex.I ∧ sK = 0
  · refine ⟨β, hβ, Or.inr ?_⟩
    intro x
    have : transK β (β x) = β (Complex.I • x) := transK_beta β x
    rw [hKrot, rot_apply, hneg.1, hneg.2] at this
    simp only [zero_smul, add_zero] at this
    rw [← this]; simp
  · -- Build the rotation `u = (pK + i, sK)` normalized.
    have hn2pos : 0 < ‖pK + Complex.I‖ ^ 2 + ‖sK‖ ^ 2 := by
      rcases eq_or_ne (pK + Complex.I) 0 with h0 | h0
      · rcases eq_or_ne sK 0 with hs0 | hs0
        · exact absurd ⟨by linear_combination h0, hs0⟩ hneg
        · have : ‖sK‖ ^ 2 > 0 := by positivity
          positivity
      · have : ‖pK + Complex.I‖ ^ 2 > 0 := by positivity
        positivity
    set n : ℝ := Real.sqrt (‖pK + Complex.I‖ ^ 2 + ‖sK‖ ^ 2) with hndef
    have hn0 : n ≠ 0 := by
      rw [hndef]; positivity
    have hnsq : (n : ℝ) ^ 2 = ‖pK + Complex.I‖ ^ 2 + ‖sK‖ ^ 2 := by
      rw [hndef, Real.sq_sqrt hn2pos.le]
    set pu : ℂ := (pK + Complex.I) / n with hpudef
    set su : ℂ := sK / n with hsudef
    have hunit : ‖pu‖ ^ 2 + ‖su‖ ^ 2 = 1 := by
      rw [hpudef, hsudef, norm_div, norm_div, div_pow, div_pow, Complex.norm_real,
        Real.norm_eq_abs, sq_abs, ← add_div, ← hnsq]
      field_simp
    set U : W ≃ₗᵢ[ℝ] W := rotEquiv θN hθN pu su hunit with hUdef
    -- `U` commutes with `N`.
    have hUcomm : RealCommutes N (betaR U) := by
      have hbU : betaR U = rot θN pu su := by
        ext w; rw [betaR_apply, hUdef, rotEquiv_apply, rot_apply]
      rw [hbU]; exact rot_realCommutes hθNc pu su
    refine ⟨β.trans U, isRealSystemIso_trans_commuting hβ hUcomm, Or.inl ?_⟩
    -- `U ∘ K = mulI ∘ U`, hence `β.trans U` is `ℂ`-linear.
    have hnC : (n : ℂ) ≠ 0 := by exact_mod_cast hn0
    have hI2 : Complex.I ^ 2 = -1 := Complex.I_sq
    have e1 : pu * pK - su * conj sK = Complex.I * pu := by
      rw [hpudef, hsudef]
      field_simp
      linear_combination hC1 - hI2
    have e2 : pu * sK + su * conj pK = Complex.I * su := by
      rw [hpudef, hsudef]
      field_simp
      linear_combination hC2
    have hstep : rot θN pu su ∘L rot θN pK sK = rot θN Complex.I 0 ∘L rot θN pu su := by
      rw [rot_comp θN hθN, rot_comp θN hθN]
      simp only [zero_mul, sub_zero, add_zero]
      rw [e1, e2]
    -- Assemble `ℂ`-linearity of `γ = β.trans U`.
    have hUrot : ∀ w, U w = rot θN pu su w := fun w => by
      rw [hUdef, rotEquiv_apply, rot_apply]
    intro x
    change U (β (Complex.I • x)) = Complex.I • U (β x)
    have hbx : β (Complex.I • x) = rot θN pK sK (β x) := by
      rw [← hKrot]; exact (transK_beta β x).symm
    rw [hbx, hUrot, hUrot, ← ContinuousLinearMap.comp_apply, hstep,
      ContinuousLinearMap.comp_apply, rot_apply]
    simp
