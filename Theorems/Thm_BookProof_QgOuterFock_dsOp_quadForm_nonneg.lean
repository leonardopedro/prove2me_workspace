-- Generated from ChapterQgOuterFockEsa.lean — theorem BookProof.QgOuterFock.dsOp_quadForm_nonneg
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

theorem BookProof.QgOuterFock.dsOp_quadForm_nonneg {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
    [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)} (H : ∀ i, D i →ₗ[ℂ] G i)
    (hpos : ∀ (i : ι) (u : D i), 0 ≤ quadForm (H i) u) (x : dsCore D) :
    0 ≤ quadForm (dsOp H) x := by sorry
