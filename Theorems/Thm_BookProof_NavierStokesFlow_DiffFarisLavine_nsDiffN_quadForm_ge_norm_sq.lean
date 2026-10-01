-- Generated from ChapterNavierStokesDiffFarisLavine.lean — theorem BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffN_quadForm_ge_norm_sq
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
theorem BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffN_quadForm_ge_norm_sq (mu : ℝ) (hmu : 0 ≤ mu) (f : polyGaussCore (d := 3)) :
    ‖(f : L2d 3)‖ ^ 2
      ≤ quadForm ((polyGaussCore (d := 3)).subtype.comp (nsDiffN mu)) f := by sorry
