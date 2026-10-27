-- Generated from ChapterNsLinearKoopmanEsa.lean — solution of BookProof.NsLinearKoopmanEsa.weylProd_id'
import Mathlib
import Definitions.Def_ChapterNsLinearKoopmanEsa
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
theorem solution (S : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    weylProd S LinearMap.id = S := by

  simp only [weylProd, LinearMap.comp_id, LinearMap.id_comp]
  rw [← two_smul ℂ S, smul_smul]
  norm_num
