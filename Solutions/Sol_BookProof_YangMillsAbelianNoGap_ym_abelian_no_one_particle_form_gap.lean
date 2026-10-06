-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.ym_abelian_no_one_particle_form_gap
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_exists_core_state_small_energy
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) {mu : ℝ} (hmu : 0 < mu) :
    ¬ ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2
        ≤ quadForm (ymHamiltonian (coreRepBasis e) (fun _ _ _ => (0 : ℝ))) x := by

  intro hgap
  obtain ⟨x, hx0, hxle⟩ := exists_core_state_small_energy e (ε := mu / 2) (by positivity)
  have hnorm : 0 < ‖(x : L2d 99)‖ ^ 2 := by
    have : (0 : ℝ) < ‖(x : L2d 99)‖ := norm_pos_iff.mpr hx0
    positivity
  have h := hgap x
  nlinarith [h, hxle, hnorm]
