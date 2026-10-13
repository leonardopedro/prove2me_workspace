-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.subset_rect
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterGradedFock
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section
open Classical

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {s : Finset (α × β)} : s ⊆ (rect s).1 ×ˢ (rect s).2 := by

  intro p hp
  exact Finset.mem_product.mpr
    ⟨Finset.mem_image_of_mem Prod.fst hp, Finset.mem_image_of_mem Prod.snd hp⟩
