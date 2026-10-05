-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.opCol_id
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.FockNumberPreservingGap

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

theorem BookProof.FockNumberPreservingGap.opCol_id (b : HilbertBasis ℕ ℂ F) (k j : ℕ) :
    opCol b (LinearMap.id) k j = if j = k then (1 : ℂ) else 0 := by sorry
