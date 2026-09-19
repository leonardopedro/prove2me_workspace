-- Generated from ChapterQg3DGaugeEsa.lean — solution of BookProof.Qg3DGaugeEsa.triple_swap
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

set_option maxHeartbeats 1000000 in
* ∑ m : Fin 64, torsionVec m i * torsionVec m j

theorem solution {α : Type*} [AddCommMonoid α] (F : Fin 64 → Fin 84 → Fin 84 → α) :
    ∑ i : Fin 84, ∑ j : Fin 84, ∑ m : Fin 64, F m i j
      = ∑ m :=
   : Fin 64, ∑ i : Fin 84, ∑ j : Fin 84, F m i j := by
    calc ∑ i : Fin 84, ∑ j : Fin 84, ∑ m : Fin 64, F m i j
        = ∑ i : Fin 84, ∑ m : Fin 64, ∑ j : Fin 84, F m i j :=
          Finset.sum_congr rfl fun _ _ => Finset.sum_comm
      _ = ∑ m : Fin 64, ∑ i :
