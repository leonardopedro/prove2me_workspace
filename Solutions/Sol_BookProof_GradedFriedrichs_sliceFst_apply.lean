-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.sliceFst_apply
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

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (b : β) (u : (α × β) →₀ ℂ) (a : α) : sliceFst b u a = u (a, b) := by

  classical
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg => rw [map_add, Finsupp.add_apply, hf, hg, Finsupp.add_apply]
  | single p c =>
    obtain ⟨a₀, b₀⟩ := p
    rw [sliceFst, Finsupp.lsum_single, LinearMap.toSpanSingleton_apply]
    simp only [Finsupp.smul_apply, smul_eq_mul, Finsupp.single_apply, Prod.mk.injEq]
    by_cases hb : b₀ = b <;> by_cases ha : a₀ = a <;> simp [ha, hb]
