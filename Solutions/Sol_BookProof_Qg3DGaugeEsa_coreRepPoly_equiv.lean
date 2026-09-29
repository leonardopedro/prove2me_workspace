-- Generated from ChapterQg3DGaugeEsa.lean — solution of BookProof.Qg3DGaugeEsa.coreRepPoly_equiv
import Mathlib
import Definitions.Def_ChapterQg3DGaugeEsa
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreEquiv_coe
open BookProof.Qg3DGaugeEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
# 4. Transport to the core of `L²(ℝ⁸⁴)` -/

theorem solution (p : MvPolynomial (Fin 84) :=
   ℂ) :
      (coreRepPoly 84).equiv p = coreEquiv p := by
    refine Subtype.ext ?_
