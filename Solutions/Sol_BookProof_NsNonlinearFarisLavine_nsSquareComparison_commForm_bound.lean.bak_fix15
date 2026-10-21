-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsSquareComparison_commForm_bound
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Theorems.Thm_BookProof_NsNonlinearFarisLavine_nsSquareComparison_quadForm
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution {L : ℝ} (hL : ∀ i, S.lam i ≤ L) (hL0 : 0 ≤ L)
    (x : polyGaussCore (d := d)) :
    |commForm (nsKoopmanOp S) (nsSquareComparison S) x|
      ≤ (2 * S.nu * L) * quadForm (nsSquareComparison S) x := by

  have hcf : commForm (nsKoopmanOp S) (nsSquareComparison S) x
      = commForm (nsKoopmanOp S) (nsEnergyOp (d := d)) x :=
    commForm_square_comparison (nsKoopmanCore S) _ (nsKoopmanOp_symmetricOn S) x
  rw [hcf]
  refine le_trans (commForm_kvn_energy_bound S hL hL0 x) ?_
  have hc : 0 ≤ 2 * S.nu * L := mul_nonneg (by linarith [S.nu_nonneg]) hL0
  refine mul_le_mul_of_nonneg_left ?_ hc
  rw [nsSquareComparison_quadForm]
  nlinarith [sq_nonneg ‖nsKoopmanOp S x‖]
