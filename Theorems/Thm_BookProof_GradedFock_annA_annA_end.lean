-- Generated from ChapterGradedFock.lean — theorem BookProof.GradedFock.annA_annA_end
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
import Mathlib
import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.GradedFock

variable {α β : Type*}
variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

theorem BookProof.GradedFock.annA_annA_end (j k : ℕ) :
    (annA j) * (annA k) - (annA k) * (annA j) = (0 : Module.End ℂ FockAlg) := by sorry
