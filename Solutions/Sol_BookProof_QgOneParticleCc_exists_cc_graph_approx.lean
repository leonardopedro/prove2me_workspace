-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.exists_cc_graph_approx
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_cut_eq_one
import Theorems.Thm_BookProof_QgOneParticleCc_exists_cut_derivative_bounds
import Theorems.Thm_BookProof_QgOneParticleCc_tendsto_tailNorm
import Theorems.Thm_BookProof_QgOneParticleCc_norm_le_tailNorm
import Theorems.Thm_BookProof_QgOneParticleCc_ccHam_coeFn
import Theorems.Thm_BookProof_QgOneParticleCc_hamCore_coeFn
import Theorems.Thm_BookProof_QgOneParticleCc_majorant_nonneg
import Theorems.Thm_BookProof_QgOneParticleCc_memLp_majorant
import Theorems.Thm_BookProof_QgOneParticleCc_cut_error_eq
import Theorems.Thm_BookProof_QgOneParticleCc_cutErr_eq_zero
import Theorems.Thm_BookProof_QgOneParticleCc_norm_cutErr_le
import Theorems.Thm_BookProof_QgOneParticleCc_norm_cutFun_sub_le
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
theorem solution (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (hWc : Continuous W) (hWb : ExpBounded W)
    (x : polyGaussCore (d := d)) {ε : ℝ} (hε : 0 < ε) :
    ∃ y : ccDomain (Vd d), ‖(y : L2d d) - (x : L2d d)‖ < ε ∧
      ‖ccHam W hWs y - hamCore W hWc hWb x‖ < ε := by

  classical
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  subst hx
  obtain ⟨C, hC0, hCbound⟩ := exists_cut_derivative_bounds d
  have hK1 : (1 : ℝ) ≤ C + 1 := by linarith
  have hGmem := memLp_majorant W hWc hWb (C + 1) p
  have hGnn := majorant_nonneg W (K := C + 1) (by linarith) p
  -- choose a radius beyond which the tail of the majorant is small
  obtain ⟨n, hnlt, hn1⟩ :=
    (((tendsto_tailNorm hGmem).eventually (gt_mem_nhds hε)).and
      (Filter.eventually_ge_atTop 1)).exists
  have hn1R : (1 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn1
  have hRpos : (0 : ℝ) < 2 * (n : ℝ) := by linarith
  have hR1 : (1 : ℝ) ≤ 2 * (n : ℝ) := by linarith
  have hball : ∀ z : Vd d, ‖z‖ ≤ (n : ℝ) → ‖z‖ < 2 * (n : ℝ) := by
    intro z hz
    linarith
  refine ⟨ccEquiv (Vd d) (cutCore (2 * (n : ℝ)) hRpos p), ?_, ?_⟩
  · -- the vectors themselves are close
    refine lt_of_le_of_lt
      (norm_le_tailNorm (S := {z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ) hGmem ?_) hnlt
    filter_upwards [Lp.coeFn_sub
        ((ccEquiv (Vd d) (cutCore (2 * (n : ℝ)) hRpos p) : ccDomain (Vd d)) : L2d d) (pgLp p),
      ((cutCore (2 * (n : ℝ)) hRpos p : ccSchwartz (Vd d)) : 𝓢(Vd d, ℂ)).coeFn_toLp 2
        (volume : Measure (Vd d)),
      pgLp_coeFn p] with z h1 h2 h3
    have hstep : ((((ccEquiv (Vd d) (cutCore (2 * (n : ℝ)) hRpos p) : ccDomain (Vd d)) : L2d d)
        - (pgLp p) : L2d d) : Vd d → ℂ) z = cutFun (2 * (n : ℝ)) p z - pgFun p z := by
      rw [h1, Pi.sub_apply, h3]
      rw [show (((ccEquiv (Vd d) (cutCore (2 * (n : ℝ)) hRpos p) : ccDomain (Vd d)) : L2d d) :
          Vd d → ℂ) z = cutFun (2 * (n : ℝ)) p z from h2]
    rw [hstep]
    by_cases hz : ‖z‖ ≤ (n : ℝ)
    · have hzero : cutFun (2 * (n : ℝ)) p z - pgFun p z = 0 := by
        simp only [cutFun]
        rw [cut_eq_one hRpos (le_of_lt (hball z hz))]
        push_cast
        ring
      rw [hzero, Set.indicator_of_notMem (by simpa using hz)]
      simp
    · rw [Set.indicator_of_mem (by simpa using hz), Real.norm_eq_abs, abs_of_nonneg (hGnn z)]
      exact norm_cutFun_sub_le W hK1 p z
  · -- the images are close
    refine lt_of_le_of_lt
      (norm_le_tailNorm (S := {z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ) hGmem ?_) hnlt
    filter_upwards [Lp.coeFn_sub
        (ccHam W hWs (ccEquiv (Vd d) (cutCore (2 * (n : ℝ)) hRpos p)))
        (hamCore W hWc hWb ⟨pgLp p, pgLp_mem_core p⟩),
      ccHam_coeFn W hWs (cutCore (2 * (n : ℝ)) hRpos p),
      hamCore_coeFn W hWc hWb p] with z h1 h2 h3
    have hstep : ((ccHam W hWs (ccEquiv (Vd d) (cutCore (2 * (n : ℝ)) hRpos p))
        - hamCore W hWc hWb ⟨pgLp p, pgLp_mem_core p⟩ : L2d d) : Vd d → ℂ) z
        = cutErr W (2 * (n : ℝ)) p z := by
      rw [h1, Pi.sub_apply, h2, h3]
      exact cut_error_eq W p z
    rw [hstep]
    by_cases hz : ‖z‖ ≤ (n : ℝ)
    · rw [cutErr_eq_zero W p (hball z hz), Set.indicator_of_notMem (by simpa using hz)]
      simp
    · rw [Set.indicator_of_mem (by simpa using hz), Real.norm_eq_abs, abs_of_nonneg (hGnn z)]
      obtain ⟨hd1, hd2⟩ := hCbound (2 * (n : ℝ)) hR1 z
      exact norm_cutErr_le W hC0 (by linarith) hR1 p z hd1 hd2
