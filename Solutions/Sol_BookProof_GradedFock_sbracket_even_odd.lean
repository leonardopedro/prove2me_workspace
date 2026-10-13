-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.sbracket_even_odd
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket
open BookProof.ChapterElectroweakFieldStrength
open BookProof.YangMillsGhost

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (a b : Module.End ℂ GradedAlg) :
    sbracket false true a b = a * b - b * a := by

  rw [sbracket, eps_false_left]
  norm_num
