-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.nsKoopman_stokes_esa
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_linKoopman_esa
import Theorems.Thm_BookProof_NsLinearKoopmanEsa_drift_eq_linDrift_of_stokes
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
theorem solution (S : NsSystem d) (hB : S.bcoef = 0) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (nsKoopmanOp S) := by

  have h : kvnPoly S = linKvnPoly (stokesMat S) 0 := by
    rw [kvnPoly, linKvnPoly]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [drift_eq_linDrift_of_stokes S hB i]
  have h2 : nsKoopmanOp S = linKoopmanOp (stokesMat S) 0 := by
    rw [nsKoopmanOp, linKoopmanOp, h]
  rw [h2]
  exact linKoopman_esa _ _
