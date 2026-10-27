-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.norm_le_cut_tail
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_memLp_bdd_mul
import Theorems.Thm_BookProof_DegKatoEsa_kato_cutoff_bound
import Theorems.Thm_BookProof_DegEnergy_contDiff_cx
import Theorems.Thm_BookProof_DegEnergy_norm_cx
import Theorems.Thm_BookProof_QgOneParticleCc_cut_eq_one
import Theorems.Thm_BookProof_QgOneParticleCc_cut_mem_Icc
import Theorems.Thm_BookProof_QgOneParticleCc_norm_le_tailNorm
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (hW1 : ∀ x, 1 ≤ W x) (S : Finset (Fin d)) {z : ℂ} (hz : z.re = 0) {u : L2d d}
    (hu : ∀ v : ccDomain (Vd d), (inner ℂ (ccHamS W hWs S v) u : ℂ)
      = z * inner ℂ ((v : L2d d)) u)
    {C : ℝ} (hC0 : 0 ≤ C) {N : ℕ} (hN : 1 ≤ N)
    (hdχ : ∀ j x, ‖dcoord j (cx (cut d (N : ℝ))) x‖ ≤ C / N) :
    ‖u‖ ≤ Real.sqrt (2 * S.card) * (C / N) * ‖u‖
      + (eLpNorm (({z : Vd d | ‖z‖ ≤ (N : ℝ)}ᶜ).indicator (fun x => ‖(u : Vd d → ℂ) x‖)) 2
          (volume : Measure (Vd d))).toReal := by

  have hR : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hR0 : (0 : ℝ) < N := by linarith
  have hu2 : MemLp (u : Vd d → ℂ) 2 (volume : Measure (Vd d)) := Lp.memLp u
  have hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cut d (N : ℝ)) := contDiff_cut (N : ℝ)
  have hχc : HasCompactSupport (cut d (N : ℝ)) := hasCompactSupport_cut hR0
  have hχI : ∀ x, cut d (N : ℝ) x ∈ Set.Icc (0 : ℝ) 1 := fun x => cut_mem_Icc x
  have hχ1 : ∀ x, |cut d (N : ℝ) x| ≤ 1 := fun x => by
    rw [abs_le]
    constructor <;> linarith [(hχI x).1, (hχI x).2]
  have hA : MemLp (fun x => cx (cut d (N : ℝ)) x * (u : Vd d → ℂ) x) 2
      (volume : Measure (Vd d)) :=
    memLp_bdd_mul (contDiff_cx hχ).continuous (fun x => by rw [norm_cx]; exact hχ1 x) hu2
  have hbd := kato_cutoff_bound W hWs hW1 S hz hu hχ hχc hχ1 hdχ hA
  have hAn : ‖hA.toLp _‖ ≤ Real.sqrt (2 * S.card) * (C / N) * ‖u‖ := by
    have hsq : 2 * (S.card : ℝ) * (C / N) ^ 2 * ‖u‖ ^ 2
        = (Real.sqrt (2 * S.card) * (C / N) * ‖u‖) ^ 2 := by
      rw [mul_pow, mul_pow, Real.sq_sqrt (by positivity)]
    rw [hsq] at hbd
    exact (pow_le_pow_iff_left₀ (norm_nonneg _) (by positivity) two_ne_zero).mp hbd
  have htail : ‖u - hA.toLp _‖ ≤ (eLpNorm (({z : Vd d | ‖z‖ ≤ (N : ℝ)}ᶜ).indicator
      (fun x => ‖(u : Vd d → ℂ) x‖)) 2 (volume : Measure (Vd d))).toReal := by
    refine norm_le_tailNorm hu2.norm ?_
    filter_upwards [Lp.coeFn_sub u (hA.toLp _), hA.coeFn_toLp] with x h1 h2
    rw [h1, Pi.sub_apply, h2]
    by_cases hx : ‖x‖ ≤ (N : ℝ)
    · have h1' : cx (cut d (N : ℝ)) x = 1 := by simp [cx, cut_eq_one hR0 hx]
      rw [h1', one_mul, sub_self, norm_zero]
      exact norm_nonneg _
    · have hmem : x ∈ ({z : Vd d | ‖z‖ ≤ (N : ℝ)}ᶜ) := hx
      rw [Set.indicator_of_mem hmem, norm_norm]
      have hfac : (u : Vd d → ℂ) x - cx (cut d (N : ℝ)) x * (u : Vd d → ℂ) x
          = ((1 - cut d (N : ℝ) x : ℝ) : ℂ) * (u : Vd d → ℂ) x := by
        simp only [cx]
        push_cast
        ring
      rw [hfac, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith [(hχI x).2])]
      have : 1 - cut d (N : ℝ) x ≤ 1 := by linarith [(hχI x).1]
      nlinarith [norm_nonneg ((u : Vd d → ℂ) x)]
  calc ‖u‖ = ‖hA.toLp _ + (u - hA.toLp _)‖ := by rw [add_sub_cancel]
    _ ≤ ‖hA.toLp _‖ + ‖u - hA.toLp _‖ := norm_add_le _ _
    _ ≤ _ := add_le_add hAn htail
