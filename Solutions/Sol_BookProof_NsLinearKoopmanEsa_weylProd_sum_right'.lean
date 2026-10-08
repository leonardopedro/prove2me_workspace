-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.weylProd_sum_right'
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_weylProd_add_right_prime
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
theorem solution {ι : Type*} (s : Finset ι) (S : Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (T : ι → Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    weylProd S (∑ j ∈ s, T j) = ∑ j ∈ s, weylProd S (T j) := by

  classical
  induction s using Finset.induction_on with
  | empty =>
      simp [weylProd]
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, weylProd_add_right_prime, ih]
