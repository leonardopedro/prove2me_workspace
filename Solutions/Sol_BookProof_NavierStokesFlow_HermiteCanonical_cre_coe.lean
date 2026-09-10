-- Generated from ChapterNavierStokesHermiteCanonical.lean — solution of BookProof.NavierStokesFlow.HermiteCanonical.cre_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical








open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes ℕ) (n : ℕ) :
    (((cre x : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (Real.sqrt n : ℂ) * ((x : L2I ℕ) : ℕ → ℂ) (n - 1) := rfl
