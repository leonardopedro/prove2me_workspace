-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.diffMaxH_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (z : maxDom (velSym (velMu A (seqConst c)))) :
    diffMaxH A c (diffMaxEquiv (velMu A (seqConst c)) z)
      = velUnitary ((velH A (seqConst c) z : L2I Vel)) := by

  simp only [diffMaxH, LinearMap.comp_apply, LinearEquiv.coe_coe,
    LinearEquiv.symm_apply_apply]
  rfl
