-- Generated from ChapterGradedFriedrichs.lean — theorem BookProof.GradedFriedrichs.ainner_eq_sum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
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
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.GradedFriedrichs



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

theorem BookProof.GradedFriedrichs.ainner_eq_sum {u : γ →₀ ℂ} {s : Finset γ} (hs : u.support ⊆ s) (v : γ →₀ ℂ) :
    ainner u v = ∑ g ∈ s, (starRingEnd ℂ) (u g) * v g := by sorry
