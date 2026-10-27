-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.magPoly_abelian
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (a : Fin 8) :
    magPoly (fun _ _ _ => 0) i a
      = ∑ j : Fin 3, ∑ k : Fin 3, ((levi i j k : ℝ) : ℂ) • X (idxD j k a) := by

  rw [magPoly]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
  simp
