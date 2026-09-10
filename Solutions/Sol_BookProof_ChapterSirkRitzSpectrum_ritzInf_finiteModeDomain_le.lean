-- Generated from ChapterSirkRitzSpectrum.lean — solution of BookProof.ChapterSirkRitzSpectrum.ritzInf_finiteModeDomain_le
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_ritzSet_finiteModeRestrict_eq
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_ritzSet_finiteModeRestrict_bddBelow
open BookProof.ChapterSirkRitzSpectrum
open BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit








noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    {x : F} (hx1 : ‖x‖ = 1) :
    ritzInf (finiteModeRestrict A b) (finiteModeDomain b) ≤ (inner ℂ x (A x) : ℂ).re := by

  have hbdd := ritzSet_finiteModeRestrict_bddBelow A b
  rw [ritzSet_finiteModeRestrict_eq A b] at hbdd
  change sInf (ritzSet (finiteModeRestrict A b) (finiteModeDomain b)) ≤ _
  rw [ritzSet_finiteModeRestrict_eq A b]
  set S : Submodule ℂ F := finiteModeDomain b with hS
  have hdense : Dense (S : Set F) := finiteModeDomain_dense b
  have hf : Continuous (fun z : F => (inner ℂ z (A z) : ℂ).re) := by fun_prop
  choose y hymem hydist using
    fun n : ℕ => Metric.mem_closure_iff.mp (hdense x) (1 / (n + 1)) (by positivity)
  have hy : Tendsto y atTop (nhds x) := by
    rw [tendsto_iff_dist_tendsto_zero]
    refine squeeze_zero (fun n => dist_nonneg) (fun n => ?_)
      tendsto_one_div_add_atTop_nhds_zero_nat
    rw [dist_comm]
    exact (hydist n).le
  have hnorm : Tendsto (fun n => ‖y n‖) atTop (nhds 1) := by
    simpa [hx1] using (continuous_norm.continuousAt.tendsto.comp hy)
  set u : ℕ → F := fun n => ‖y n‖⁻¹ • y n with hu
  have hutend : Tendsto u atTop (nhds x) := by
    have h1 : Tendsto (fun n => ‖y n‖⁻¹) atTop (nhds 1) := by
      simpa using hnorm.inv₀ (by norm_num)
    have := h1.smul hy
    simpa [hu] using this
  have hev : ∀ᶠ n in atTop, ‖u n‖ = 1 := by
    have hpos : ∀ᶠ n in atTop, (0 : ℝ) < ‖y n‖ := hnorm.eventually_const_lt (by norm_num)
    filter_upwards [hpos] with n hn
    rw [hu]
    simp [norm_smul, hn.ne']
  have hle : ∀ᶠ n in atTop, sInf {t : ℝ | ∃ w : F, w ∈ S ∧ ‖w‖ = 1 ∧
      t = (inner ℂ w (A w) : ℂ).re} ≤ (inner ℂ (u n) (A (u n)) : ℂ).re := by
    filter_upwards [hev] with n hn
    exact csInf_le hbdd ⟨u n, S.smul_mem _ (hymem n), hn, rfl⟩
  exact ge_of_tendsto ((hf.tendsto x).comp hutend) hle
