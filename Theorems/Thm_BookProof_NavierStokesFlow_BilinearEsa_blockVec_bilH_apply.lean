-- Generated from ChapterNavierStokesBilinearEsa.lean — theorem BookProof.NavierStokesFlow.BilinearEsa.blockVec_bilH_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}


theorem BookProof.NavierStokesFlow.BilinearEsa.blockVec_bilH_apply (κ : J → ℝ) (x : lpFiniteModes (ℕ × J)) (j : J) (n : ℕ) :
    ((bilH κ x : L2I (ℕ × J)) : ℕ × J → ℂ) (n, j)
      = hFun (κ j) (fun m => ((x : L2I (ℕ × J)) : ℕ × J → ℂ) (m, j)) n := by sorry
