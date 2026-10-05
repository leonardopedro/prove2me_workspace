-- Generated from ChapterF2.lean — theorem BookProof.ChapterF2.massGap_smallest_excited
import Definitions.Def_ChapterF1
import Mathlib
import Definitions.Def_ChapterF2
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow.FullEsa
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.ChapterF2


open Polynomial Finset
open scoped BigOperators


open BookProof.ChapterF1

noncomputable section

theorem BookProof.ChapterF2.massGap_smallest_excited (n : ℕ) (hn : n ≠ 0) :
    hamiltonian (X ^ n) = (n : ℂ) • X ^ n ∧ (1 : ℕ) ≤ n := by sorry
