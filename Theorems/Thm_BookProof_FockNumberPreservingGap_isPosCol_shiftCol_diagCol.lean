-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.isPosCol_shiftCol_diagCol
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.FockNumberPreservingGap


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

theorem BookProof.FockNumberPreservingGap.isPosCol_shiftCol_diagCol {e : ℕ → ℝ} {mu : ℝ} (he : ∀ k, mu ≤ e k) :
    IsPosCol (shiftCol (diagCol e) mu) := by sorry
