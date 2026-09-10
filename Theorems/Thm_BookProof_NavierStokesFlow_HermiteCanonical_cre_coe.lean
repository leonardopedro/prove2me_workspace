-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical







open scoped ENNReal



open BookProof.NavierStokesFlow.LpNat BookProof.FarisLavine BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.cre_coe (x : lpFiniteModes ℕ) (n : ℕ) :
    (((cre x : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (Real.sqrt n : ℂ) * ((x : L2I ℕ) : ℕ → ℂ) (n - 1) := by sorry
