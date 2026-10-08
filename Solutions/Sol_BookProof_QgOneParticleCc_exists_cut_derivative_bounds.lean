-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.exists_cut_derivative_bounds
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_fderiv_cut
import Theorems.Thm_BookProof_QgOneParticleCc_norm_scaleCLM_le
import Theorems.Thm_BookProof_QgOneParticleCc_dcoord_ofReal
import Theorems.Thm_BookProof_QgOneParticleCc_fderiv_fderiv_cut
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ R : ℝ, 1 ≤ R → ∀ x : Vd d,
      (∀ j : Fin d, ‖dcoord j (fun y => ((cut d R y : ℝ) : ℂ)) x‖ ≤ C / R) ∧
        ‖lapC (fun y => ((cut d R y : ℝ) : ℂ)) x‖ ≤ C / R ^ 2 := by

  classical
  -- bounds on the first and second derivative of the fixed bump
  have hbump := bump_spec d
  have hcs1 : HasCompactSupport (fun y : Vd d => fderiv ℝ (bump d) y) := hbump.2.1.fderiv ℝ
  have hcont1 : Continuous (fun y : Vd d => fderiv ℝ (bump d) y) :=
    hbump.1.continuous_fderiv (by simp)
  obtain ⟨C₁, hC₁⟩ := hcs1.exists_bound_of_continuous hcont1
  have hcs2 : HasCompactSupport (fun y : Vd d => fderiv ℝ (fun z : Vd d => fderiv ℝ (bump d) z) y)
    := hcs1.fderiv ℝ
  have hbd : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y : Vd d => fderiv ℝ (bump d) y) :=
    hbump.1.fderiv_right (m := ((⊤ : ℕ∞) : WithTop ℕ∞)) le_rfl
  have hcont2 : Continuous (fun y : Vd d => fderiv ℝ (fun z : Vd d => fderiv ℝ (bump d) z) y) :=
    hbd.continuous_fderiv (by simp)
  obtain ⟨C₂, hC₂⟩ := hcs2.exists_bound_of_continuous hcont2
  have hC₁nn : 0 ≤ C₁ := le_trans (norm_nonneg _) (hC₁ 0)
  have hC₂nn : 0 ≤ C₂ := le_trans (norm_nonneg _) (hC₂ 0)
  refine ⟨max C₁ (d * C₂), le_trans hC₁nn (le_max_left _ _), fun R hR x => ?_⟩
  have hRpos : (0 : ℝ) < R := lt_of_lt_of_le zero_lt_one hR
  have hcutC : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cut d R) := contDiff_cut R
  -- the first-derivative bound
  have hfirst : ∀ j : Fin d, ‖dcoord j (fun y => ((cut d R y : ℝ) : ℂ)) x‖ ≤ C₁ / R := by
    intro j
    rw [dcoord_ofReal hcutC j x]
    have hnorm : ‖kinDir d j‖ = 1 := by
      simp [kinDir, EuclideanSpace.norm_single]
    have hle : ‖fderiv ℝ (cut d R) x (kinDir d j)‖ ≤ ‖fderiv ℝ (cut d R) x‖ := by
      simpa [hnorm] using (fderiv ℝ (cut d R) x).le_opNorm (kinDir d j)
    have hcomp : ‖fderiv ℝ (cut d R) x‖ ≤ C₁ * R⁻¹ := by
      rw [fderiv_cut]
      refine le_trans (ContinuousLinearMap.opNorm_comp_le _ _) ?_
      exact mul_le_mul (hC₁ _) (norm_scaleCLM_le hRpos) (norm_nonneg _) hC₁nn
    have : ‖((fderiv ℝ (cut d R) x (kinDir d j) : ℝ) : ℂ)‖
        = ‖fderiv ℝ (cut d R) x (kinDir d j)‖ := by
      simp [Complex.norm_real]
    rw [this]
    calc ‖fderiv ℝ (cut d R) x (kinDir d j)‖ ≤ ‖fderiv ℝ (cut d R) x‖ := hle
      _ ≤ C₁ * R⁻¹ := hcomp
      _ = C₁ / R := by field_simp
  -- the second-derivative (Laplacian) bound
  have hsecond : ∀ j : Fin d,
      ‖dcoord j (dcoord j (fun y => ((cut d R y : ℝ) : ℂ))) x‖ ≤ C₂ / R ^ 2 := by
    intro j
    have hcoe : dcoord j (fun z : Vd d => ((cut d R z : ℝ) : ℂ))
        = fun y : Vd d => ((fderiv ℝ (cut d R) y (kinDir d j) : ℝ) : ℂ) := by
      funext y
      exact dcoord_ofReal hcutC j y
    have hsm : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
        (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) := by
      have hfd : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y : Vd d => fderiv ℝ (cut d R) y) :=
        hcutC.fderiv_right (m := ((⊤ : ℕ∞) : WithTop ℕ∞)) le_rfl
      exact (ContinuousLinearMap.apply ℝ ℝ (kinDir d j)).contDiff.comp hfd
    rw [hcoe, dcoord_ofReal hsm j x]
    have hnorm : ‖kinDir d j‖ = 1 := by
      simp [kinDir, EuclideanSpace.norm_single]
    have hev : fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x
        = (ContinuousLinearMap.apply ℝ ℝ (kinDir d j)).comp
            (fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y) x) := by
      have hfd : DifferentiableAt ℝ (fun y : Vd d => fderiv ℝ (cut d R) y) x := by
        have h : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun y : Vd d => fderiv ℝ (cut d R) y) :=
          hcutC.fderiv_right (m := ((⊤ : ℕ∞) : WithTop ℕ∞)) le_rfl
        exact (h.differentiable (by simp)) x
      exact (((ContinuousLinearMap.apply ℝ ℝ
        (kinDir d j)).hasFDerivAt).comp x hfd.hasFDerivAt).fderiv
    have hb : ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y) x‖ ≤ C₂ * (R⁻¹ * R⁻¹) := by
      rw [fderiv_fderiv_cut]
      refine le_trans (ContinuousLinearMap.opNorm_comp_le _ _) ?_
      have hflip : ‖((ContinuousLinearMap.compL ℝ (Vd d) (Vd d) ℝ).flip (scaleCLM d R))‖ ≤ R⁻¹ := by
        refine ContinuousLinearMap.opNorm_le_bound _ (by positivity) fun L => ?_
        have h1 : ‖L.comp (scaleCLM d R)‖ ≤ ‖L‖ * ‖scaleCLM d R‖ :=
          ContinuousLinearMap.opNorm_comp_le _ _
        have h2 : ‖L‖ * ‖scaleCLM d R‖ ≤ ‖L‖ * R⁻¹ :=
          mul_le_mul_of_nonneg_left (norm_scaleCLM_le hRpos) (norm_nonneg _)
        calc ‖((ContinuousLinearMap.compL ℝ (Vd d) (Vd d) ℝ).flip (scaleCLM d R)) L‖
            = ‖L.comp (scaleCLM d R)‖ := rfl
          _ ≤ ‖L‖ * R⁻¹ := le_trans h1 h2
          _ = R⁻¹ * ‖L‖ := by ring
      have hinner : ‖(fderiv ℝ (fun y : Vd d => fderiv ℝ (bump d) y)
          (scaleCLM d R x)).comp (scaleCLM d R)‖ ≤ C₂ * R⁻¹ := by
        refine le_trans (ContinuousLinearMap.opNorm_comp_le _ _) ?_
        exact mul_le_mul (hC₂ _) (norm_scaleCLM_le hRpos) (norm_nonneg _) hC₂nn
      have := mul_le_mul hflip hinner (norm_nonneg _) (by positivity)
      calc ‖((ContinuousLinearMap.compL ℝ (Vd d) (Vd d) ℝ).flip (scaleCLM d R))‖ *
            ‖(fderiv ℝ (fun y : Vd d => fderiv ℝ (bump d) y)
              (scaleCLM d R x)).comp (scaleCLM d R)‖
          ≤ R⁻¹ * (C₂ * R⁻¹) := this
        _ = C₂ * (R⁻¹ * R⁻¹) := by ring
    have hfin : ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x (kinDir d j)‖
        ≤ C₂ * (R⁻¹ * R⁻¹) := by
      have h1 : ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x (kinDir d j)‖
          ≤ ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x‖ := by
        simpa [hnorm] using
          (fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x).le_opNorm (kinDir d j)
      have h2 : ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x‖
          ≤ ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y) x‖ := by
        rw [hev]
        refine le_trans (ContinuousLinearMap.opNorm_comp_le _ _) ?_
        have : ‖ContinuousLinearMap.apply ℝ ℝ (kinDir d j)‖ ≤ 1 := by
          refine ContinuousLinearMap.opNorm_le_bound _ zero_le_one fun L => ?_
          simpa [hnorm] using L.le_opNorm (kinDir d j)
        nlinarith [norm_nonneg (fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y) x),
          norm_nonneg (ContinuousLinearMap.apply ℝ ℝ (kinDir d j))]
      linarith
    have hcast : ‖((fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x (kinDir d j)
        : ℝ) : ℂ)‖
        = ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x (kinDir d j)‖ := by
      simp [Complex.norm_real]
    rw [hcast]
    calc ‖fderiv ℝ (fun y : Vd d => fderiv ℝ (cut d R) y (kinDir d j)) x (kinDir d j)‖
        ≤ C₂ * (R⁻¹ * R⁻¹) := hfin
      _ = C₂ / R ^ 2 := by field_simp
  refine ⟨fun j => le_trans (hfirst j) (by gcongr; exact le_max_left _ _), ?_⟩
  have hsum : ‖lapC (fun y => ((cut d R y : ℝ) : ℂ)) x‖ ≤ ∑ _j : Fin d, C₂ / R ^ 2 := by
    refine le_trans (norm_sum_le _ _) ?_
    exact Finset.sum_le_sum fun j _ => hsecond j
  have hsimp : ∑ _j : Fin d, C₂ / R ^ 2 = (d : ℝ) * C₂ / R ^ 2 := by
    simp [Finset.sum_const, mul_div_assoc]
  rw [hsimp] at hsum
  refine le_trans hsum ?_
  gcongr
  exact le_max_right _ _
