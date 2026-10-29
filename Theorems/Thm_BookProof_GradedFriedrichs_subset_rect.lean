-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.subset_rect
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterSirkBandLedger
import Definitions.Def_ChapterVielbeinFiberFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization

noncomputable section

variable {γ : Type*}
variable {α β : Type*}
open Classical

theorem BookProof.GradedFriedrichs.subset_rect {s : Finset (α × β)} : s ⊆ (rect s).1 ×ˢ (rect s).2 := by sorry
