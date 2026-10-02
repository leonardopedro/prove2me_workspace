-- Generated from ChapterYangMillsAbelianFockEsa.lean — solution of BookProof.YmAbelianFock.coreRep_op_sum
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Theorems.Thm_BookProof_YmAbelianFock_coreRep_op_add




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D) {ι : Type*} (s : Finset ι)
    (F : ι → Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Φ.op (∑ i ∈ s, F i) = ∑ i ∈ s, Φ.op (F i) := by

  classical
  induction s using Finset.induction_on with
  | empty => refine LinearMap.ext fun x => ?_; simp [CoreRep.op_apply]
  | insert a s ha ih => rw [Finset.sum_insert ha, coreRep_op_add, ih, Finset.sum_insert ha]
