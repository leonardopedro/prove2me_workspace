-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.mulOp_C'
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
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
theorem solution (a : ℂ) : mulOp (C a : MvPolynomial (Fin d) ℂ) = a • LinearMap.id := by

  refine LinearMap.ext fun p => ?_
  simp [MvPolynomial.smul_eq_C_mul]
