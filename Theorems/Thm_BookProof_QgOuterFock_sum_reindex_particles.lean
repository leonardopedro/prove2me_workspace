-- Generated from ChapterQgOuterFockEsa.lean — theorem BookProof.QgOuterFock.sum_reindex_particles
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

theorem BookProof.QgOuterFock.sum_reindex_particles {n : ℕ} {α : Type*} [AddCommMonoid α] (F : Fin (n * 84) → α) :
    ∑ I : Fin (n * 84), F I = ∑ p : Fin n, ∑ j : Fin 84, F (pcoord p j) := by sorry
