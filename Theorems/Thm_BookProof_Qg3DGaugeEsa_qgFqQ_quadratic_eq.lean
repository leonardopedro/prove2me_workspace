-- Generated from ChapterQg3DGaugeEsa.lean — theorem BookProof.Qg3DGaugeEsa.qgFqQ_quadratic_eq
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

in 84, ∑ j : Fin 84, F m i j := Finset.sum_comm

theorem BookProof.Qg3DGaugeEsa.qgFqQ_quadratic_eq :
    ∑ i : Fin 84, ∑ j : Fin 84, ((qgFqQ i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin 84) ℂ) * X j)
      = ((1 / 2 : ℝ) := by sorry
