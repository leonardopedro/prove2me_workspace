-- Generated from ChapterNavierStokesBilinearEsa.lean — theorem BookProof.NavierStokesFlow.BilinearEsa.hasSum_inner_blocks
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


theorem BookProof.NavierStokesFlow.BilinearEsa.hasSum_inner_blocks (x y : L2I (ℕ × J)) :
    HasSum (fun j : J => (inner ℂ (blockVec x j) (blockVec y j) : ℂ)) (inner ℂ x y) := by sorry
