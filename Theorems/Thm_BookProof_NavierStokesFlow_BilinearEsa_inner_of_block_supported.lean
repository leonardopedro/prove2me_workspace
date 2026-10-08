-- Generated from ChapterNavierStokesBilinearEsa.lean — theorem BookProof.NavierStokesFlow.BilinearEsa.inner_of_block_supported
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}


theorem BookProof.NavierStokesFlow.BilinearEsa.inner_of_block_supported (j : J) (x : L2I (ℕ × J)) (a : L2I ℕ)
    (hx : ∀ p, (x : ℕ × J → ℂ) p = embFun j ((a : ℕ → ℂ)) p) (w : L2I (ℕ × J)) :
    (inner ℂ x w : ℂ) = inner ℂ a (blockVec w j) := by sorry
