-- Generated from ChapterQg3DGaugeEsa.lean — theorem BookProof.Qg3DGaugeEsa.pgLp_qgSignedPoly
import Mathlib
import Definitions.Def_ChapterQg3DGaugeEsa
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

theorem BookProof.Qg3DGaugeEsa.pgLp_qgSignedPoly (kappa : Fin 84 → ℝ) (p : MvPolynomial (Fin 84) ℂ) :
    pgLp (qgSignedPoly kappa p)
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j : Fin 84, ((kappa j : ℝ) : ℂ) • pgLp (pmom j (pmom j p)))
            + ∑ m : Fin 64, pgLp (torsionP m * (torsionP m * p))) := by sorry
