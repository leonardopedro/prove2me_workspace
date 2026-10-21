-- Generated from ChapterNsNonlinearFarisLavine.lean — solution of BookProof.NsNonlinearFarisLavine.nsKoopman_esa_of_squareComparison_esa
import Mathlib
import Definitions.Def_ChapterNsNonlinearFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lam_nonneg
open BookProof.NsNonlinearFarisLavine




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ} (S : NsSystem d)

variable {d : ℕ} (S : NsSystem d)

set_option maxHeartbeats 1000000 in
theorem solution
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := d)) (nsSquareComparison S)) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (nsKoopmanOp S) := by

  obtain ⟨L, hL, hL0⟩ : ∃ L : ℝ, (∀ i, S.lam i ≤ L) ∧ 0 ≤ L :=
    ⟨∑ i, S.lam i, fun i => Finset.single_le_sum (fun j _ => S.lam_nonneg j)
      (Finset.mem_univ i), Finset.sum_nonneg fun j _ => S.lam_nonneg j⟩
  exact essentiallySelfAdjointOn_of_square_comparison polyGaussCore_dense (nsKoopmanCore S)
    (nsEnergyOp (d := d)) (2 * S.nu * L) (nsKoopmanOp_symmetricOn S) nsEnergyOp_symmetricOn
    (mul_nonneg (by linarith [S.nu_nonneg]) hL0) nsEnergyOp_quadForm_nonneg
    (commForm_kvn_energy_bound S hL hL0) hN
