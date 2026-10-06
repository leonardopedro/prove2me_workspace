-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.rankTwo_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato


theorem BookProof.NavierStokesFlow.MomentumPerturbation.rankTwo_symmetric (u w x y : L2I ι) :
    (inner ℂ (rankTwo u w x) y : ℂ) = inner ℂ x (rankTwo u w y) := by sorry
