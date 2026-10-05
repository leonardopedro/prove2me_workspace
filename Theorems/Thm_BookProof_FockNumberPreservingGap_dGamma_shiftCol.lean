-- Generated from ChapterFockNumberPreservingGap.lean — theorem BookProof.FockNumberPreservingGap.dGamma_shiftCol
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

theorem BookProof.FockNumberPreservingGap.dGamma_shiftCol (col : ℕ → (ℕ →₀ ℂ)) (mu : ℝ) (u : FockAlg) :
    dGamma (shiftCol col mu) u
      = dGamma col u - ((mu : ℝ) : ℂ) • dGamma numberCol u := by sorry
