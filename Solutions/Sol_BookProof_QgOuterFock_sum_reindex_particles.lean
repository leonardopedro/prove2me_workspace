-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.sum_reindex_particles
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
theorem solution {n : ℕ} {α : Type*} [AddCommMonoid α] (F : Fin (n * 84) → α) :
    ∑ I : Fin (n * 84), F I = ∑ p : Fin n, ∑ j : Fin 84, F (pcoord p j) := by

  calc ∑ I : Fin (n * 84), F I = ∑ qi : Fin n × Fin 84, F (pcoord qi.1 qi.2) :=
        (Fintype.sum_equiv finProdFinEquiv (fun qi => F (pcoord qi.1 qi.2)) F fun _ => rfl).symm
    _ = ∑ p : Fin n, ∑ j : Fin 84, F (pcoord p j) :=
        Fintype.sum_prod_type (fun qi : Fin n × Fin 84 => F (pcoord qi.1 qi.2))
