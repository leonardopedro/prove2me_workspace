-- Generated from ChapterNavierStokesDiffFarisLavine.lean — theorem BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)




open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffH_commForm_bound :
    ∃ cst : ℝ, 0 ≤ cst ∧ ∀ f : polyGaussCore (d := 3),
      |commForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c))
          ((polyGaussCore (d := 3)).subtype.comp (nsDiffN (diffMu A c))) f|
        ≤ cst * quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN (diffMu A c))) f := by sorry
