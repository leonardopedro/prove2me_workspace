-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation




open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_relative_bound (c : ι → ℝ) (u w : L2I ι) (x : maxDom c) :
    ‖pertHam c u w x‖ ^ 2
      ≤ 2 * ‖diagMax c x‖ ^ 2 + (2 * (2 * (‖u‖ * ‖w‖)) ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by sorry
