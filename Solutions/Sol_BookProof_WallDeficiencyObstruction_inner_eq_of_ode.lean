-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.inner_eq_of_ode
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Theorems.Thm_BookProof_WallDeficiencyObstruction_integral_conj_deriv2_mul
import Theorems.Thm_BookProof_ScalaronEsa_ccEquiv_coe
import Theorems.Thm_BookProof_ScalaronEsa_opCc_apply
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ)
    {W W' : ℝ → ℂ} (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW' : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x)
    (hmem : MemLp W 2 (volume : Measure ℝ)) (v : ccDomain ℝ) :
    (inner ℂ (wallHam V hV v) (hmem.toLp W) : ℂ)
      = z * inner ℂ (v : Lp ℂ 2 (volume : Measure ℝ)) (hmem.toLp W) := by

  classical
  set u : Lp ℂ 2 (volume : Measure ℝ) := hmem.toLp W with hu
  have hae : ∀ᵐ x : ℝ, u x = W x := hmem.coeFn_toLp
  -- write `v` through the core equivalence
  obtain ⟨ψ, rfl⟩ : ∃ ψ : ccSchwartz ℝ, ccEquiv ℝ ψ = v := ⟨(ccEquiv ℝ).symm v, by simp⟩
  set P : ℝ → ℂ := fun x => ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x with hPdef
  have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) P := (ψ : 𝓢(ℝ, ℂ)).smooth _
  have hPd : ∀ x, HasDerivAt P (deriv P x) x := fun x =>
    (hsmooth.differentiable (by simp) x).hasDerivAt
  have hsmooth' : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv P) := hsmooth.deriv'
  have hP'd : ∀ x, HasDerivAt (deriv P) (deriv (deriv P) x) x := fun x =>
    (hsmooth'.differentiable (by simp) x).hasDerivAt
  have hsmooth'' : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv P)) := hsmooth'.deriv'
  have hP''c : Continuous (deriv (deriv P)) := hsmooth''.continuous
  have hPsupp : HasCompactSupport P := ψ.2
  have hPcont : Continuous P := hsmooth.continuous
  have hWcont : Continuous W := continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
  have hGc : Continuous fun x => (((V x : ℝ) : ℂ) - z) * W x :=
    (((Complex.continuous_ofReal.comp hV.continuous).sub continuous_const).mul hWcont)
  -- the three pieces of the pairing
  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ ψ)
      = schwartzEquiv ℝ (ψ : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ ψ) = (kinOpR (ψ : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  have hkinint : (inner ℂ (kinCcR (ccEquiv ℝ ψ)) u : ℂ)
      = -∫ x, (starRingEnd ℂ) (deriv (deriv P) x) * W x := by
    rw [hkin, inner_toLp_left, ← integral_neg]
    refine integral_congr_ae ?_
    filter_upwards [hae] with x hx
    change (starRingEnd ℂ) ((kinOpR (ψ : 𝓢(ℝ, ℂ))) x) * u x
      = -((starRingEnd ℂ) (deriv (deriv P) x) * W x)
    rw [kinOpR_apply, hx]
    simp [hPdef]
  have hpot : (inner ℂ (opCc V hV (ccEquiv ℝ ψ)) u : ℂ)
      = ∫ x, ((V x : ℝ) : ℂ) * ((starRingEnd ℂ) (P x) * W x) := by
    rw [opCc_apply, inner_toLp_left]
    refine integral_congr_ae ?_
    filter_upwards [hae] with x hx
    simp only [mulCc_apply, map_mul, Complex.conj_ofReal, hx, hPdef]
    ring
  have hplain : (inner ℂ ((ccEquiv ℝ ψ : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) u : ℂ)
      = ∫ x, (starRingEnd ℂ) (P x) * W x := by
    rw [ccEquiv_coe, inner_toLp_left]
    refine integral_congr_ae ?_
    filter_upwards [hae] with x hx
    rw [hx]
  -- integration by parts
  have hIBP : ∫ x, (starRingEnd ℂ) (deriv (deriv P) x) * W x
      = ∫ x, (starRingEnd ℂ) (P x) * ((((V x : ℝ) : ℂ) - z) * W x) :=
    integral_conj_deriv2_mul hPd hP'd hP''c hPsupp hW hW' hGc
  -- split the right-hand side
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (P x) * W x) volume :=
    ((Complex.continuous_conj.comp hPcont).mul hWcont).integrable_of_hasCompactSupport
      ((hPsupp.comp_left (g := fun w : ℂ => (starRingEnd ℂ) w) (by simp)).mul_right)
  have hint2 : Integrable (fun x => ((V x : ℝ) : ℂ) * ((starRingEnd ℂ) (P x) * W x)) volume :=
    (((Complex.continuous_ofReal.comp hV.continuous)).mul
      ((Complex.continuous_conj.comp hPcont).mul hWcont)).integrable_of_hasCompactSupport
        (HasCompactSupport.mul_left
          ((hPsupp.comp_left (g := fun w : ℂ => (starRingEnd ℂ) w) (by simp)).mul_right))
  have hsplit : ∫ x, (starRingEnd ℂ) (P x) * ((((V x : ℝ) : ℂ) - z) * W x)
      = (∫ x, ((V x : ℝ) : ℂ) * ((starRingEnd ℂ) (P x) * W x))
        - z * ∫ x, (starRingEnd ℂ) (P x) * W x := by
    rw [← MeasureTheory.integral_const_mul, ← integral_sub hint2 (hint1.const_mul z)]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  simp only [wallHam, LinearMap.add_apply, inner_add_left, hkinint, hpot, hplain]
  rw [hIBP, hsplit]
  ring
