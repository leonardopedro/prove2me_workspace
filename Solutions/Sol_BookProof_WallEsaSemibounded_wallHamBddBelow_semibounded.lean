-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.wallHamBddBelow_semibounded
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_WallEsaSemibounded_kinCcR_quadratic_form
import Theorems.Thm_BookProof_WallEsaSemibounded_ccEquiv_norm_sq
import Theorems.Thm_BookProof_WallEsaSemibounded_opCc_quadratic_form
open BookProof.WallEsaSemibounded




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
ards [(f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx]
  simp only [mulCc_apply, map_mul, Complex.conj_ofReal, Complex.ofReal_mul]
  rw [mul_assoc, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]

theorem solution (f : ccSchwartz ℝ) :
    ‖((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
      = ∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  have h := inner_toLp_self (f : 𝓢(ℝ :=
  , ℂ))
    rw [← ccEquiv_coe] at h
    rw [← inner_self_eq_norm_sq (𝕜 := ℂ)
      ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)), h]
    simp
  
  /-! ## The packaging lemma -/
  
  /-- **The quadratic form of `−d²/dx² + V` is bounded below by `-c` when `V ≥ -c`.**
  This is the semiboundedness the shift-invert (Hashimoto/SIRK) schemes work with: together
  with `wallHam_essentiallySelfAdjoint_of_bddBelow` it says that the closed operator selected
  by the closure of `wallHam V hV` is the semibounded one. -/
  theorem wallHamBddBelow_semibounded (V : ℝ → ℝ)
      (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
      SemiboundedBelowOn (ccDomain ℝ) (wallHam V hV) c := by
    intro v
    obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective v
    have hk := kinCcR_quadratic_form f
    have hp := opCc_quadratic_form V hV f
    have hn := ccEquiv_norm_sq f
    have hcf : Continuous ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) := (f : 𝓢(ℝ, ℂ)).continuous
    have hsq : Continuous fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by fun_prop
    have hsupp : HasCompactSupport fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
      f.2.comp_left (g := fun z : ℂ => ‖z‖ ^ 2) (by simp)
    have hI0 : Integrable fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
      hsq.integrable_of_hasCompactSupport hsupp
    have hIV : Integrable fun x => V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
      ((hV.continuous.
