-- Generated from ChapterYangMillsAbelianEsa.lean — theorem BookProof.YangMillsAbelianEsa.triple_swap'
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
open BookProof.YangMillsAbelianEsa



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.YangMillsAbelianEsa.triple_swap' {α : Type*} [AddCommMonoid α] {N D : ℕ} (F : Fin N → Fin D → Fin D → α) :
    ∑ i : Fin D, ∑ j : Fin D, ∑ m : Fin N, F m i j
      = ∑ m : Fin N, ∑ i : Fin D, ∑ j : Fin D, F m i j := by sorry
