-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.rankTwo_norm_le
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation




open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.MomentumPerturbation.rankTwo_norm_le (u w x : L2I ι) : ‖rankTwo u w x‖ ≤ 2 * (‖u‖ * ‖w‖) * ‖x‖ := by sorry
