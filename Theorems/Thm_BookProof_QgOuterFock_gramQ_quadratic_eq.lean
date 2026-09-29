-- Generated from ChapterQgOuterFockEsa.lean — theorem BookProof.QgOuterFock.gramQ_quadratic_eq
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.QgOuterFock



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.QgHermiteOscillator
open BookProof.DirectSumEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.QgOuterFock.gramQ_quadratic_eq {R : Type*} [Fintype R] (v : R → Fin D → ℝ) :
    ∑ i : Fin D, ∑ j : Fin D, ((gramQ v i j : ℝ) : ℂ)
        • ((X i : MvPolynomial (Fin D) ℂ) * X j)
      = ((1 / 2 : ℝ) : ℂ) • ∑ r : R, linForm (v r) * linForm (v r) := by sorry
