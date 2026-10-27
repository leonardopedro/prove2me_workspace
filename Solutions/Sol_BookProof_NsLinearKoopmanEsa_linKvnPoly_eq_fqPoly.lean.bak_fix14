-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.linKvnPoly_eq_fqPoly
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_add_right_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_smul_right_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_sum_right_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_comm_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_add_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_smul_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_sum_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_C_prime
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_id_prime
import Theorems.Thm_BookProof_HermiteRelative_momPoly_eq_ymMomOp
import Theorems.Thm_BookProof_HermiteRelative_mulXPoly_eq_mulOp
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.NsKoopman
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.FockSecondQuantization BookProof.QuadFockEsa

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Fin d → Fin d → ℝ) (c : Fin d → ℝ) :
    linKvnPoly A c = fqPoly 0 0 (fun j i => A i j) 0 c := by

  have hterm : ∀ i : Fin d, weylProd (momOp i) (mulOp (linDrift A c i))
      = (∑ j, ((A i j : ℝ) : ℂ) • weylProd (mulXPoly j) (momPoly i))
        + ((c i : ℝ) : ℂ) • momPoly i := by
    intro i
    rw [linDrift, mulOp_add_prime, mulOp_sum_prime, weylProd_add_right_prime, weylProd_sum_right_prime, mulOp_C_prime,
      weylProd_smul_right_prime, weylProd_id_prime, momPoly_eq_ymMomOp]
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [mulOp_smul_prime, weylProd_smul_right_prime, weylProd_comm_prime, mulXPoly_eq_mulOp]
  rw [linKvnPoly, Finset.sum_congr rfl fun i _ => hterm i, Finset.sum_add_distrib, fqPoly,
    fqQuadPoly, foPoly]
  simp only [Pi.zero_apply, Complex.ofReal_zero, zero_smul, zero_add]
  rw [Finset.sum_comm]
