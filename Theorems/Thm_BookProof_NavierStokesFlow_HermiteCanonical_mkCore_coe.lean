-- Generated from ChapterNavierStokesHermiteCanonical.lean — theorem BookProof.NavierStokesFlow.HermiteCanonical.mkCore_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteCanonical
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteCanonical







open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine

theorem BookProof.NavierStokesFlow.HermiteCanonical.mkCore_coe {X : ℕ → ℂ} (h : (Function.support X).Finite) (n : ℕ) :
    (((mkCore h : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n = X n := by sorry
