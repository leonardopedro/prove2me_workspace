-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.subset_rect
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {s : Finset (α × β)} : s ⊆ (rect s).1 ×ˢ (rect s).2 := by

  intro p hp
  exact Finset.mem_product.mpr
    ⟨Finset.mem_image_of_mem Prod.fst hp, Finset.mem_image_of_mem Prod.snd hp⟩
