-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.triple_swap'
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

set_option maxHeartbeats 1000000 in
theorem solution {R : Type*} [Fintype R] {α : Type*} [AddCommMonoid α]
    (F : R → Fin D → Fin D → α) :
    ∑ i : Fin D, ∑ j : Fin D, ∑ r : R, F r i j
      = ∑ r : R, ∑ i : Fin D, ∑ j : Fin D, F r i j := by

  calc ∑ i : Fin D, ∑ j : Fin D, ∑ r : R, F r i j
      = ∑ i : Fin D, ∑ r : R, ∑ j : Fin D, F r i j :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ r : R, ∑ i : Fin D, ∑ j : Fin D, F r i j := Finset.sum_comm
