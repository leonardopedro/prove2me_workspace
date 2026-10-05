-- Generated from ChapterF1.lean — theorem BookProof.ChapterF1.bargmann_creat_annih
import Mathlib
import Definitions.Def_ChapterF1
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.ChapterF1


open Polynomial Finset
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF1.bargmann_creat_annih (m n : ℕ) :
    bargmann (creat (X ^ m)) (X ^ n) = bargmann (X ^ m) (annih (X ^ n)) := by sorry
