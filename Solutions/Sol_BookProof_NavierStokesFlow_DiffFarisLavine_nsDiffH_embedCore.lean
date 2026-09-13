-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffH_embedCore
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine














open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

















variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution (x : lpFiniteModes Vel) :
    ((nsDiffH A c (embedCore x) : polyGaussCore (d := 3)) : L2d 3)
      = velUnitary ((canH A (seqConst c) x : lpFiniteModes Vel) : L2I Vel) := by

  have hc : (fun j => Real.sqrt 2 * (seqConst c j)) = c := by
    funext j
    simp only [seqConst]
    field_simp
  have h := intertwined_canH A (seqConst c) x
  rw [hc] at h
  rw [h, embedCore_coe]
