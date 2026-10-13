-- Generated from ChapterGradedFock.lean — solution of BookProof.GradedFock.even_add_odd
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.GradedFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket
open BookProof.YangMillsGhost

noncomputable section

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))

set_option maxHeartbeats 1000000 in
theorem solution (u : GradedAlg) : evenPart u + oddPart u = u := by

  rw [evenPart, oddPart, ← smul_add]
  have h : u + gradeOp u + (u - gradeOp u) = (2 : ℂ) • u := by
    rw [two_smul]; abel
  rw [h, smul_smul, inv_mul_cancel₀ (two_ne_zero), one_smul]
