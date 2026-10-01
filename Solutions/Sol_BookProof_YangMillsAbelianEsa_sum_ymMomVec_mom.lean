-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.sum_ymMomVec_mom
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

set_option maxHeartbeats 1000000 in
theorem solution (m : Fin 24) :
    ∑ n : Fin 99, ((ymMomVec m n : ℝ) : ℂ) • momPoly (d := 99) n
      = momPoly (ymMomIdx m) := by

  rw [Finset.sum_eq_single (ymMomIdx m)]
  · simp [ymMomVec]
  · intro b _ hb
    simp [ymMomVec, hb]
  · intro h
    exact absurd (Finset.mem_univ (ymMomIdx m)) h
