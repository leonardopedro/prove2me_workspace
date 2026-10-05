-- Generated from ChapterF1.lean — theorem BookProof.ChapterF1.numberOp_monomial
import Mathlib
import Definitions.Def_ChapterF1
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.GhostField
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.ChapterF1


open Polynomial Finset
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF1.numberOp_monomial (n : ℕ) : numberOp (X ^ n) = (n : ℂ) • X ^ n := by sorry
