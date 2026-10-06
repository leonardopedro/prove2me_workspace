-- Generated from ChapterNavierStokesBilinearEsa.lean — theorem BookProof.NavierStokesFlow.BilinearEsa.embFun_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa

variable {J : Type*}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine


theorem BookProof.NavierStokesFlow.BilinearEsa.embFun_of_ne {j j' : J} (a : ℕ → ℂ) (n : ℕ) (h : j' ≠ j) : embFun j a (n, j') = 0 := by sorry
