-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.linKvnPoly_eq_fqPoly
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_add_right'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_smul_right'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_sum_right'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_comm'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_add'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_smul'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_sum'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_mulOp_C'
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_id'
import Theorems.Thm_BookProof_HermiteRelative_momPoly_eq_ymMomOp
import Theorems.Thm_BookProof_HermiteRelative_mulXPoly_eq_mulOp
open BookProof.NsLinearKoopmanEsa




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
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
    rw [linDrift, mulOp_add', mulOp_sum', weylProd_add_right', weylProd_sum_right', mulOp_C',
      weylProd_smul_right', weylProd_id', momPoly_eq_ymMomOp]
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [mulOp_smul', weylProd_smul_right', weylProd_comm', mulXPoly_eq_mulOp]
  rw [linKvnPoly, Finset.sum_congr rfl fun i _ => hterm i, Finset.sum_add_distrib, fqPoly,
    fqQuadPoly, foPoly]
  simp only [Pi.zero_apply, Complex.ofReal_zero, zero_smul, zero_add]
  rw [Finset.sum_comm]
