-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation

variable {ι : Type*}




open LpNat BookProof.FarisLavine IkebeKato


theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_symmetricOn (c : ι → ℝ) (u w : L2I ι) :
    SymmetricOn (maxDom c) (pertHam c u w) := by sorry
