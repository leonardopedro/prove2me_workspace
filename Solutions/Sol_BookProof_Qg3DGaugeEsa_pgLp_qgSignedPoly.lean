-- Generated from ChapterQg3DGaugeEsa.lean — solution of BookProof.Qg3DGaugeEsa.pgLp_qgSignedPoly
import Mathlib
import Definitions.Def_ChapterQg3DGaugeEsa
import Theorems.Thm_BookProof_Qg3DGaugeEsa_qgSignedPoly_apply
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
(Fin 84) ℂ) : pgLp p = pgMap (d := 84) p := rfl

theorem solution (kappa : Fin 84 → ℝ) (p : MvPolynomial (Fin 84) ℂ) :
    pgLp (qgSignedPoly kappa p)
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j : Fin 84, ((kappa j : ℝ) : ℂ) • pgLp (pmom j (pmom j p)))
            + ∑ :=
   m : Fin 64, pgLp (torsionP m * (torsionP m * p))) := by
    rw [qgSignedPoly_apply]
    si
