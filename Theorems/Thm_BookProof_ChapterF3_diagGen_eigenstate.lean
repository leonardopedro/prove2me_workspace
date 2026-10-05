-- Generated from ChapterF3.lean — theorem BookProof.ChapterF3.diagGen_eigenstate
import Mathlib
import Definitions.Def_ChapterF3
import Definitions.Def_ChapterGhostField
open BookProof.GhostField
open BookProof.ChapterF3

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped BigOperators
open Polynomial


noncomputable section

theorem BookProof.ChapterF3.diagGen_eigenstate (a : ℂ) (n : ℕ) :
    (a • ChapterF1.numberOp) (X ^ n) = (a * n) • X ^ n := by sorry
