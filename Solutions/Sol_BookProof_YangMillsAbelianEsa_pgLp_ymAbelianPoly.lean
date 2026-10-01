-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.pgLp_ymAbelianPoly
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
import Theorems.Thm_BookProof_YangMillsAbelianEsa_ymAbelianPoly_apply
open BookProof.YangMillsAbelianEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin 99) ℂ) :
    pgLp (ymAbelianPoly p)
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ m : Fin 24, pgLp (YangMillsHermite.momOp (ymMomIdx m)
              (YangMillsHermite.momOp (ymMomIdx m) p)))
            + ∑ m : Fin 24, pgLp (mulOp (magPoly 0 (decodeSpace m) (decodeColor m))
                (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) p))) := by

  rw [ymAbelianPoly_apply]
  simp only [pgLp_eq_pgMap, map_smul, map_add, map_sum]
